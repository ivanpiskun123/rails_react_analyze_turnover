# read args
import sys

# create and use keras NN with LSTM to forecast with time series
import numpy as np
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import Flatten

results_file_path = "lib/assets/python/results.txt"
# input data (array of data in .csv file) stored in file .csv
input_file_path = "lib/assets/python/input_data.txt"

# amount of epochs per one model training
EPOCH_COUNTS = 250

# prepare training data chunks from input data
def prepare_data(timeseries_data, n_features):
	X, y =[],[]
	for i in range(len(timeseries_data)):
		# find the end of this pattern
		end_ix = i + n_features
		# check if we are beyond the sequence
		if end_ix > len(timeseries_data)-1:
			break
		# gather input and output parts of the pattern
		seq_x, seq_y = timeseries_data[i:end_ix], timeseries_data[end_ix]
		X.append(seq_x)
		y.append(seq_y)
	return np.array(X), np.array(y)

# get input data from file
lines_raw = []
with open(input_file_path) as f:
	lines_raw = f.readlines()

lines = []
for line in lines_raw:
	lines.append([ int(x) for x in line.split() ] )

# depth - depth of forecasting, for example we have 12-sized array of data, we want to predict 4 following values. Here Depth = 4
depth = int(len(lines[0])/3)
output = []

# write results to output file for following charts rendering
f = open(results_file_path, "w")

for timeseries_data in lines:
	# # training data : [a,b,c,d,e, ...] : [a,b,c]->d, [b,c,d]->e, ...
	n_steps = 3
	X, y = prepare_data(timeseries_data, n_steps)

	# # reshape from [samples, timesteps] into [samples, timesteps, features]

	n_features = 1
	X = X.reshape((X.shape[0], X.shape[1], n_features))

	# # define Neural Network Model
	model = Sequential()
	model.add(LSTM(50, activation='relu', return_sequences=True, input_shape=(n_steps, n_features)))
	model.add(LSTM(50, activation='relu'))
	model.add(Dense(1))
	model.compile(optimizer='adam', loss='mse')

	# fit model (training)
	model.fit(X, y, epochs=EPOCH_COUNTS , verbose=1)

	# make predictions to next depth-values
	x_input = np.array(  timeseries_data[-3:] )
	temp_input=list(x_input)
	# predictions list
	lst_output=[]
	i=0
	while(i<int(depth)):
	    if(len(temp_input)>3):
	        x_input=np.array(temp_input[1:])
	        #print(x_input)
	        x_input = x_input.reshape((1, n_steps, n_features))
	        #print(x_input)
	        yhat = model.predict(x_input, verbose=0)
	        temp_input.append(yhat[0][0])
	        temp_input=temp_input[1:]
	        #print(temp_input)
	        lst_output.append(yhat[0][0])
	        i=i+1
	    else:
	        x_input = x_input.reshape((1, n_steps, n_features))
	        yhat = model.predict(x_input, verbose=0)
	        temp_input.append(yhat[0][0])
	        lst_output.append(yhat[0][0])
	        i=i+1
	output.append(lst_output)

	for e in timeseries_data:
		f.write(str(round(e)) +" ")
	for e in lst_output:
		f.write(str(round(e)) +" ")

	f.write("\n")


f.close()

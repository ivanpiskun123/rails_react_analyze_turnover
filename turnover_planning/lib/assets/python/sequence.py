import sys
root_path = '/home/ivan/Рабочий стол/'
out_path = "lib/assets/python/results.txt"
import numpy as np
import pandas as pd
f = open(out_path, "w")


# -------------------------------------------------------------------
# -------------------------------------------------------------------


import keras
file_path = sys.argv[1]

df=pd.read_csv(root_path + file_path)

numbers_column = [i for i in range(1,len(df)+1)]
df.insert(0,'num', numbers_column)

train_len = int( len(df)/5*4 )
train_part = df[:train_len]
val_part = df[train_len:]

X = train_part.iloc[:, :-1]
Y = train_part.iloc[:, -1:]

x_val = val_part.iloc[:, :-1]
y_val = val_part.iloc[:, -1:]


model = keras.models.Sequential()
model.add(keras.layers.Dense(1, activation='linear', input_shape=(1,)))
model.add(keras.layers.Dense(1, activation='linear'))

model.compile(optimizer='adam', loss='mean_squared_error', metrics=['mean_absolute_percentage_error'])


model.fit(X, Y, epochs=800,batch_size=None, callbacks=[keras.callbacks.EarlyStopping(monitor='val_loss', patience=3)],
          validation_data=(x_val, y_val),
        verbose=True)

n_predict = int(sys.argv[2][1:-1])

for i in range(0,n_predict):
    f.write(str(  round(float(model.predict( [len(df)+1+i], batch_size=1 )[0][0])   )))
    f.write(" ")
    print(model.predict([len(df)+1+i], batch_size=1))

score = model.evaluate(x_val, y_val)
f.write(str(score[1]))
f.close()

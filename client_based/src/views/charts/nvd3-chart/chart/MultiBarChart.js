import React from 'react';
import NVD3Chart from 'react-nvd3';


const MultiBarChart = ({data}) => {

  return <NVD3Chart type="multiBarChart"
                    datum={data} x="x" y="y"
                    height={300} showValues
                    groupSpacing={0.2}
  />;
};

export default MultiBarChart;

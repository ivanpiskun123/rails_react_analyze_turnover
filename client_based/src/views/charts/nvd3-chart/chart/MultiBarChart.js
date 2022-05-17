import React from 'react';
import NVD3Chart from 'react-nvd3';

function generateNumber(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

function getDatum() {
  let sin = [],
    sin2 = [];

  const len = 35 + Math.random() * (70 - 35);
  for (let i = 0; i < len; i++) {
    sin.push({
      x: i,
      y: generateNumber(0, 60)
    });
    sin2.push({
      x: i,
      y: generateNumber(0, 100)
    });
  }
  return [
    {
      values: sin,
      key: 'План продаж',
      color: '#A389D4'
    },
    {
      values: sin2,
      key: 'Выполнено продаж',
      color: '#1de9b6',
      area: true
    }
  ];
}

const MultiBarChart = () => {
  const data = getDatum();
  return <NVD3Chart type="multiBarChart" datum={data} x="x" y="y" height={300} showValues groupSpacing={0.2} />;
};

export default MultiBarChart;

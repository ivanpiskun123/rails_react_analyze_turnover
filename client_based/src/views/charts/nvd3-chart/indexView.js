import React from 'react';
import { Row, Col, Card } from 'react-bootstrap';

import LineChart from './chart/LineChart';
import BarDiscreteChart from './chart/BarDiscreteChart';
import PieDonutChart from './chart/PieDonutChart';
import PieBasicChart from './chart/PieBasicChart';
import MultiBarChart from './chart/MultiBarChart';

const Nvd3Chart = () => {
  return (
    <React.Fragment>
      <Row>
        <Col md={6}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">Средняя цена реализации</Card.Title>
            </Card.Header>
            <Card.Body>
              <LineChart />
            </Card.Body>
          </Card>
        </Col>
        <Col md={6}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">Товарно групповая структура</Card.Title>
            </Card.Header>
            <Card.Body>
              <BarDiscreteChart />
            </Card.Body>
          </Card>
        </Col>
        <Col sm={12}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">Структура товарооборота по формам торговли</Card.Title>
            </Card.Header>
            <Card.Body>
              <MultiBarChart />
            </Card.Body>
          </Card>
        </Col>
        <Col md={6}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">Сезонность товарооборота</Card.Title>
            </Card.Header>
            <Card.Body className="text-center">
              <PieBasicChart />
            </Card.Body>
          </Card>
        </Col>
        <Col md={6}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">Структура по формам оплаты</Card.Title>
            </Card.Header>
            <Card.Body className="text-center">
              <PieDonutChart />
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </React.Fragment>
  );
};

export default Nvd3Chart;

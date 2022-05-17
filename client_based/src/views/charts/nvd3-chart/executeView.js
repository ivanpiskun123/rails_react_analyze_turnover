import React, {useState} from 'react';
import {Row, Col, Card, Collapse, Table} from 'react-bootstrap';

import LineChart from './chart/LineChart';
import BarDiscreteChart from './chart/BarDiscreteChart';
import PieDonutChart from './chart/PieDonutChart';
import PieBasicChart from './chart/PieBasicChart';
import MultiBarChart from './chart/MultiBarChart';
import {Link} from "react-router-dom";

const ExecuteView = () => {

  const [accordionKey, setAccordionKey] = useState(1);



  return (
    <React.Fragment>
      <Row>

        <Col sm={12} className="accordion">
          <Card className="mt-2">
            <Card.Header>
              <Card.Title as="h5">
                <Link
                    to="#"
                    onClick={() => setAccordionKey(accordionKey !== 1 ? 1 : 0)}
                    aria-controls="accordion1"
                    aria-expanded={accordionKey === 1}
                >
                  Динамика выполнения плана
                </Link>
              </Card.Title>
            </Card.Header>
            <Collapse in={accordionKey === 1}>
              <div id="accordion1">
                <Card.Body>
                  <Card.Text>
                    Динамика выполнения плана продаж - это те целевые значения объемов продаж
                    (в деньгах или в натуральном выражении), которые
                    ставятся перед сотрудником или отделом продаж на отчетный период.
                    Планы продаж бывают годовые, квартальные, месячные и недельные.
                    Планирование продаж может быть реализовано различными методами, в том числе рассчетным.
                  </Card.Text>
                </Card.Body>
              </div>
            </Collapse>
          </Card>
        </Col>

        <Col sm={12}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">Динамика выполнения</Card.Title>
            </Card.Header>
            <Card.Body>
              <MultiBarChart />
            </Card.Body>
          </Card>
        </Col>

        <Col sm={12}>
        <Card >
          <Card.Header>
            <Card.Title as="h5">Объемы и значения</Card.Title>
            <span className="d-block m-t-5">
                строки выделенные <code>красным</code> соответствуют месяцам со <code>слабым</code> выполнением плана
              </span>
          </Card.Header>
          <Card.Body>
            <Table responsive hover>
              <thead>
              <tr>
                <th>#</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Username</th>
              </tr>
              </thead>
              <tbody>
              <tr>
                <th scope="row">1</th>
                <td>Mark</td>
                <td>Otto</td>
                <td>@mdo</td>
              </tr>
              <tr>
                <th scope="row">2</th>
                <td>Jacob</td>
                <td>Thornton</td>
                <td>@fat</td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>Larry</td>
                <td>the Bird</td>
                <td>@twitter</td>
              </tr>
              </tbody>
            </Table>
          </Card.Body>
        </Card>
        </Col>

      </Row>
    </React.Fragment>
  );
};

export default ExecuteView;

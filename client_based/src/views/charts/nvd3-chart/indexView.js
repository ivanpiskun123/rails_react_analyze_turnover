import React, {useState,useEffect, useContext} from 'react';
import {Row, Col, Card, Collapse, Table} from 'react-bootstrap';

import LineChart from './chart/LineChart';
import BarDiscreteChart from './chart/BarDiscreteChart';
import PieDonutChart from './chart/PieDonutChart';
import PieBasicChart from './chart/PieBasicChart';
import MultiBarChart from './chart/MultiBarChart';
import {Link} from "react-router-dom";
import PagesService from "../../../API/PagesService";
import {AuthContext} from "../../../contexts/AuthContext";

const IndexView = () => {

  const [accordionKey, setAccordionKey] = useState(1);
  const [dataChart,setDataChart] = useState([])
  const [dataTable,setDataTable] = useState([])
  const {currentYear} = useContext(AuthContext);

  const fetchData = async  ()=>{
    try{
      const response = await PagesService.getIndexedPlan(currentYear)
      let planData =  response.data.data.plan.map(a => {return {x: a[0], y: a[1]}}  )
      let execData =  response.data.data.exec.map(a => {return {x: a[0], y: a[1]}}  )
      let indexData =  response.data.data.index.map(a => {return {x: a[0], y: a[1]}}  )

      const chartData = [
        {
          values: planData,
          key: 'План продаж',
          color: '#A389D4'
        },
        {
          values: execData,
          key: 'Выполнено продаж',
          color: '#1de9b6',
          area: true
        },
        {
          values: indexData,
          key: 'Индексированные продажи',
          color: '#04a9f5'
        }
      ];

      setDataChart(chartData);
      setDataTable(response.data.data.table)
      console.log(response.data)
    }
    catch(e){
      console.log(e) }
  }

  useEffect(()=>{
    fetchData()
  },[])

  useEffect(()=>{
    console.log(currentYear)
    fetchData()
  },[currentYear])

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
                    Индексированные продажи
                  </Link>
                </Card.Title>
              </Card.Header>
              <Collapse in={accordionKey === 1}>
                <div id="accordion1">
                  <Card.Body>
                    <Card.Text>
                      Индекс потребительских цен (ИПЦ) отражает изменение во времени стоимости
                      фиксированного набора товаров и услуг,
                      фактически приобретаемых населением для непроизводственного потребления.
                      ИПЦ является исключительно показателем изменения цен, а не стоимости жизни,
                      поскольку он не учитывает изменений в структуре текущего потребления населения республики.
                    </Card.Text>
                  </Card.Body>
                </div>
              </Collapse>
            </Card>
          </Col>

          <Col sm={12}>
            <Card>
              <Card.Header>
                <Card.Title as="h5">Индексированная динамика выполнения</Card.Title>
              </Card.Header>
              <Card.Body>
                <MultiBarChart data={dataChart}/>
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
                    <th>№</th>
                    <th>Месяц</th>
                    <th>Продано</th>
                    <th>Индекс</th>
                    <th>Индексированные</th>
                    <th>Темп роста %</th>
                    <th>Темп ПРИроста %</th>
                  </tr>
                  </thead>
                  <tbody>
                  {
                    dataTable.map((x) => {
                      return (
                          <tr  style={{ color: "black", backgroundColor: x[5]<85 && "#FF8694" } }   >
                            <th scope="row">{x[0]}</th>
                            <td>{x[1]}</td>
                            <td>{x[2]}</td>
                            <td>{x[3]}</td>
                            <td>{x[4]}</td>
                            <td>{x[5]}</td>
                            <td>{x[6]}</td>
                          </tr>
                      )
                    })
                  }

                  </tbody>
                </Table>
              </Card.Body>
            </Card>
          </Col>

        </Row>
      </React.Fragment>
  );
};

export default IndexView;

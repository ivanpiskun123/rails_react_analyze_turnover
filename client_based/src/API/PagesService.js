import axios from 'axios';

export default class PagesService {

        static async getYears() {
            const response  = axios.get('http://localhost:3000/pages/get-years/', {
                headers: {
                    'Content-Type': 'application/json',
                    'authorization': localStorage.getItem('token')
                }
            });
            return response;
        }

        static async getDynamicPlan(year) {
          const response  = axios.get('http://localhost:3000/pages/dynamic-plan-execution/', {
              params: {
                  year: year
              },
            headers: {
              'Content-Type': 'application/json',
              'authorization': localStorage.getItem('token')
            }
           });
       return response;
        }

    static async getIndexedPlan(year) {
        const response  = axios.get('http://localhost:3000/pages/dynamic-indexed-sales/', {
            params: {
                year: year
            },
            headers: {
                'Content-Type': 'application/json',
                'authorization': localStorage.getItem('token')
            }
        });
        return response;
    }

    static async getSeasons(year) {
        const response  = axios.get('http://localhost:3000/pages/seasonality-sctructure/', {
            params: {
                year: year
            },
            headers: {
                'Content-Type': 'application/json',
                'authorization': localStorage.getItem('token')
            }
        });
        return response;
    }

    static async getTradeForms(year) {
        const response  = axios.get('http://localhost:3000//pages/trade-form-sctructure/', {
            params: {
                year: year
            },
            headers: {
                'Content-Type': 'application/json',
                'authorization': localStorage.getItem('token')
            }
        });
        return response;
    }

    static async getPaymentForms(year) {
        const response  = axios.get('http://localhost:3000//pages/payment-method-sctructure/', {
            params: {
                year: year
            },
            headers: {
                'Content-Type': 'application/json',
                'authorization': localStorage.getItem('token')
            }
        });
        return response;
    }


    static async getGroups(year) {
        const response  = axios.get('http://localhost:3000//pages/product-group-structure/', {
            params: {
                year: year
            },
            headers: {
                'Content-Type': 'application/json',
                'authorization': localStorage.getItem('token')
            }
        });
        return response;
    }

    static async getXyz(year) {
        const response  = axios.get('http://localhost:3000/pages/xyz_analysis/', {
            params: {
                year: year
            },
            headers: {
                'Content-Type': 'application/json',
                'authorization': localStorage.getItem('token')
            }
        });
        return response;
    }




}
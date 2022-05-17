import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router } from 'react-router-dom';
import { FirebaseProvider } from './contexts/FirebaseContext';
import routes, { renderRoutes } from './routes';
import { BASENAME } from './config/constant';
import {AuthContext} from "./contexts/AuthContext";
import {privateRoutes, publicRoutes} from "./routesConfig";

const App = () => {

    const [isAuth, setIsAuth] = useState(false);
    const [currentUserId, setCurrentUserId] = useState(null);

    useEffect( ()=> {
            setIsAuth(false)
            if(localStorage.getItem('auth'))
            {
                setIsAuth(true)
            }

            }
        ,[])

    const logOut = ()=>{
        const logOutUser = async () => {
            try {
                localStorage.removeItem('token')
                localStorage.removeItem('auth')
                localStorage.removeItem('user_id')
                setIsAuth(false)
            } catch (e) {
                console.log(e)
            }
        }
        logOutUser()
    }


  return (
    <React.Fragment>
      <Router basename={BASENAME}>
        <FirebaseProvider>
            <AuthContext.Provider value={{
                isAuth,
                setIsAuth,
                currentUserId,
                setCurrentUserId ,
                logOut
            }}>
                {
                    isAuth
                    ?
                        renderRoutes(privateRoutes)
                        :
                        renderRoutes(publicRoutes)
                }

            </AuthContext.Provider>
        </FirebaseProvider>

      </Router>
    </React.Fragment>

  );
};

export default App;

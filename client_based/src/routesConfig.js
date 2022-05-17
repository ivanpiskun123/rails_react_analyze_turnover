import React, {lazy} from "react";
import AdminLayout from "./layouts/AdminLayout";
import {Redirect} from "react-router-dom";
import {BASE_URL} from "./config/constant";

export const privateRoutes = [
    {
        path: '*',
        layout: AdminLayout,
        routes: [

            {
                exact: true,
                path: '/app/dashboard/default',
                component: lazy(() => import('./views/dashboard/DashDefault'))
            },
            {
                exact: true,
                path: '/basic/button',
                component: lazy(() => import('./views/ui-elements/basic/BasicButton'))
            },
            {
                exact: true,
                path: '/basic/badges',
                component: lazy(() => import('./views/ui-elements/basic/BasicBadges'))
            },
            {
                exact: true,
                path: '/basic/breadcrumb',
                component: lazy(() => import('./views/ui-elements/basic/BasicBreadcrumb'))
            },
            {
                exact: true,
                path: '/basic/pagination',
                component: lazy(() => import('./views/ui-elements/basic/BasicPagination'))
            },
            {
                exact: true,
                path: '/basic/collapse',
                component: lazy(() => import('./views/ui-elements/basic/BasicCollapse'))
            },
            {
                exact: true,
                path: '/basic/tabs-pills',
                component: lazy(() => import('./views/ui-elements/basic/BasicTabsPills'))
            },
            {
                exact: true,
                path: '/basic/typography',
                component: lazy(() => import('./views/ui-elements/basic/BasicTypography'))
            },
            {
                exact: true,
                path: '/forms/form-basic',
                component: lazy(() => import('./views/forms/FormsElements'))
            },
            {
                exact: true,
                path: '/tables/bootstrap',
                component: lazy(() => import('./views/tables/BootstrapTable'))
            },
            {
                exact: true,
                path: '/charts/execute',
                component: lazy(() => import('./views/charts/nvd3-chart/executeView'))
            },
            {
                exact: true,
                path: '/charts/index',
                component: lazy(() => import('./views/charts/nvd3-chart/indexView'))
            },
            {
                exact: true,
                path: '/sample-page',
                component: lazy(() => import('./views/extra/SamplePage'))
            },
            {
                path: '*',
                exact: true,
                component: () => <Redirect to={BASE_URL} />
            }
        ]
    }
];

export const publicRoutes = [
    {
        exact: true,
        path: '/auth/signin-1',
        component: lazy(() => import('./views/auth/signin/SignIn1'))
    }
]


const menuItems = {
  items: [
    {
      id: 'forms-tables',
      title: 'Обобщающий анализ',
      type: 'group',
      icon: 'icon-group',
      children: [
        {
          id: 'forms',
          title: 'Present-отчёт',
          type: 'item',
          url: '/app/dashboard/default',
          icon: 'feather icon-home ',
        }
      ]
    },
    {
      id: 'navigation',
      title: 'Степень важности ресурсов',
      type: 'group',
      icon: 'feather icon-server',
      children: [
        {
          id: 'breadcrumb',
          title: 'XYZ-анализ ресурсов',
          type: 'item',
          url: '/sample-page',
          icon: 'feather icon-menu',
        },
        {
          id: 'dashboard',
          title: 'ABC-анализ ресурсов',
          type: 'item',
          url: '/app/dashboard/default',
          icon: 'feather icon-server',
        },
        {
          id: 'breadcrumb',
          title: 'Отчёт групп ресурсов',
          type: 'item',
          url: '/sample-page',
          icon: 'feather icon-menu',
        },
      ]
    },
    {
      id: 'ui-element',
      title: 'Анализ динамики продаж',
      type: 'group',
      icon: 'feather icon-file-text',
      children: [
        {
          id: 'time',
          title: 'Анализ по датам',
          type: 'collapse',
          icon: 'feather icon-calendar',
          children: [
            {
              id: 'button',
              title: 'Выполнение продаж',
              type: 'item',
              url: '/charts/execute'
            },
            {
              id: 'badges',
              title: 'Индексированный анализ',
              type: 'item',
              url: '/charts/index'
            },
            {
              id: 'tabs-pills',
              title: 'Сезонность',
              type: 'item',
              url: '/basic/tabs-pills'
            }
          ]
        }
      ]
    }
    ,
    {
      id: 'ui-element',
      title: 'Анализ основных величин',
      type: 'group',
      icon: 'feather icon-file-text',
      children: [
        {
          id: 'basic',
          title: 'Специальные величины',
          type: 'collapse',
          icon: 'feather icon-pie-chart',
          children: [
            {
              id: 'pagination',
              title: 'Формы оплаты',
              type: 'item',
              url: '/basic/pagination'
            },
            {
              id: 'collapse',
              title: 'Формы торговли',
              type: 'item',
              url: '/basic/collapse'
            },
            {
              id: 'typography',
              title: 'Средняя цена продаж',
              type: 'item',
              url: '/basic/typography'
            }
          ]
        }
      ]
    }
      ]
};

export default menuItems;





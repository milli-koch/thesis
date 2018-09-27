view: user_order_facts {
  derived_table: {
    explore_source: order_items {
      column: user_id {field: order_items.user_id}
      column: lifetime_number_of_orders {field: order_items.order_count}
      column: lifetime_customer_value {field: order_items.total_revenue}
      derived_column: average_customer_order {
        sql:  lifetime_customer_value / lifetime_number_of_orders ;;
      }
    }
    }
    }

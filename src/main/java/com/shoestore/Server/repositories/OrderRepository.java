package com.shoestore.Server.repositories;

import com.shoestore.Server.dto.response.OrderStatusCountResponse;
import com.shoestore.Server.dto.response.RevenueSeriesResponse;
import com.shoestore.Server.entities.Order;
import com.shoestore.Server.enums.OrderStatus;
import com.shoestore.Server.enums.PaymentMethod;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Integer>, JpaSpecificationExecutor<Order> {
    List<Order> findByUser_UserID(int userID);

    Order findByCode(String code);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.user.userID = :userId")
    int countOrdersByUserId(int userId);

    @Query("SELECT SUM(o.total) FROM Order o WHERE o.user.userID = :userId AND o.status = 'DELIVERED'")
    Double sumTotalAmountByUserId(int userId);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.user.userID = :userId AND o.status = 'DELIVERED'")
    int countDeliveredOrdersByUserId(@Param("userId") int userId);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.orderDate = :date")
    long countByOrderDate(@Param("date") LocalDate date);

    @Query("SELECT COUNT(o) FROM Order o WHERE FUNCTION('MONTH', o.orderDate) = :month AND FUNCTION('YEAR', o.orderDate) = :year")
    long countByMonthAndYear(@Param("month") int month, @Param("year") int year);

    @Query("SELECT COUNT(o) FROM Order o WHERE FUNCTION('YEAR', o.orderDate) = :year")
    long countByYear(@Param("year") int year);

    @Query("SELECT COALESCE(SUM(o.total), 0) FROM Order o")
    Double sumTotalOrderAmount();

    @Query("SELECT COALESCE(SUM(o.total), 0) FROM Order o WHERE o.orderDate = :today")
    Double sumTotalOrderAmountByDay(@Param("today") LocalDate today);

    @Query("SELECT COALESCE(SUM(o.total), 0) FROM Order o WHERE FUNCTION('MONTH', o.orderDate) = :month AND FUNCTION('YEAR', o.orderDate) = :year")
    Double sumTotalOrderAmountByMonth(@Param("month") int month, @Param("year") int year);

    @Query("SELECT COALESCE(SUM(o.total), 0) FROM Order o WHERE FUNCTION('YEAR', o.orderDate) = :year")
    Double sumTotalOrderAmountByYear(@Param("year") int year);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = 'DELIVERED'")
    long countCompletedOrders();

    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = 'DELIVERED' AND o.orderDate = :today")
    long countCompletedOrdersByDay(@Param("today") LocalDate today);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = 'DELIVERED' AND FUNCTION('MONTH', o.orderDate) = :month AND FUNCTION('YEAR', o.orderDate) = :year")
    long countCompletedOrdersByMonth(@Param("month") int month, @Param("year") int year);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = 'DELIVERED' AND FUNCTION('YEAR', o.orderDate) = :year")
    long countCompletedOrdersByYear(@Param("year") int year);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = 'CANCELED'")
    long countCanceledOrders();

    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = 'CANCELED' AND o.orderDate = :today")
    long countCanceledOrdersByDay(@Param("today") LocalDate today);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = 'CANCELED' AND FUNCTION('MONTH', o.orderDate) = :month AND FUNCTION('YEAR', o.orderDate) = :year")
    long countCanceledOrdersByMonth(@Param("month") int month, @Param("year") int year);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = 'CANCELED' AND FUNCTION('YEAR', o.orderDate) = :year")
    long countCanceledOrdersByYear(@Param("year") int year);

    @Query("SELECT o FROM Order o WHERE " +
            "CAST(o.orderID as string) LIKE CONCAT('%', :query, '%') " +
            "OR LOWER(o.user.name) LIKE LOWER(CONCAT('%', :query, '%'))")
    List<Order> searchOrders(@Param("query") String query);


    @Query("SELECT o FROM Order o WHERE o.orderDate = :day")
    Page<Order> findByOrderDate(@Param("day") LocalDate day, Pageable pageable);

    @Query("SELECT o FROM Order o WHERE FUNCTION('MONTH', o.orderDate) = :month AND FUNCTION('YEAR', o.orderDate) = :year")
    Page<Order> findByMonthAndYear(@Param("month") int month, @Param("year") int year, Pageable pageable);

    @Query("SELECT o FROM Order o WHERE FUNCTION('YEAR', o.orderDate) = :year")
    Page<Order> findByYear(@Param("year") int year, Pageable pageable);

    @Query("SELECT SUM(o.total) FROM Order o " +
            "WHERE EXISTS (SELECT od FROM OrderDetail od " +
            "JOIN od.productDetail pd " +
            "JOIN pd.product p " +
            "WHERE od.order = o AND p.promotion IS NOT NULL)")
    BigDecimal getRevenueFromPromotions();

    @Query("SELECT COUNT(DISTINCT o) FROM Order o " +
            "WHERE EXISTS (SELECT od FROM OrderDetail od " +
            "JOIN od.productDetail pd " +
            "JOIN pd.product p " +
            "WHERE od.order = o AND p.promotion IS NOT NULL)")
    long countOrdersWithPromotions();

    @Query("SELECT SUM(o.total) FROM Order o")
    Double sumTotalAmount();

    @Query("SELECT SUM(o.total) FROM Order o WHERE o.orderDate BETWEEN :start AND :end")
    Optional<Double> sumTotalBetween(@Param("start") LocalDate start,
                                     @Param("end") LocalDate end);

    long countByOrderDateBetween(LocalDate start, LocalDate end);

    @Query(value = """
              SELECT 
                DATE_FORMAT(o.createdAt,
                  CASE
                    WHEN :tf = 'daily'   THEN '%Y-%m-%d'
                    WHEN :tf = 'weekly'  THEN '%x-W%v'
                    WHEN :tf = 'monthly' THEN '%Y-%m'
                    WHEN :tf = 'yearly'  THEN '%Y'
                  END
                ) AS period,
                SUM(o.total) AS revenue,
                COUNT(*)     AS orders
              FROM orders o
              WHERE o.createdAt BETWEEN :start AND :end
              GROUP BY period
              ORDER BY period
            """, nativeQuery = true)
    List<Object[]> fetchRawRevenueSeries(
            @Param("tf") String timeFrame,
            @Param("start") LocalDate start,
            @Param("end") LocalDate end
    );


    @Query("""
              SELECT new com.shoestore.Server.dto.response.OrderStatusCountResponse(
                o.status,
                COUNT(o)
              )
              FROM Order o
              WHERE o.orderDate BETWEEN :start AND :end
              GROUP BY o.status
            """)
    List<OrderStatusCountResponse> fetchOrderStatusCounts(
            @Param("start") LocalDate start,
            @Param("end") LocalDate end
    );

    @Query(value = """
              WITH first_order AS (
                SELECT userID,
                       MIN(orderDate) AS first_date
                FROM Orders
                GROUP BY userID
              )
              SELECT
                DATE_FORMAT(o.orderDate, '%Y-%m')              AS month,
                COUNT(DISTINCT CASE WHEN fo.first_date BETWEEN
                     STR_TO_DATE(CONCAT(DATE_FORMAT(o.orderDate, '%Y-%m'), '-01'), '%Y-%m-%d')
                   AND LAST_DAY(o.orderDate)
                   THEN o.userID END)                          AS new_customers,
                COUNT(DISTINCT CASE WHEN fo.first_date <
                     STR_TO_DATE(CONCAT(DATE_FORMAT(o.orderDate, '%Y-%m'), '-01'), '%Y-%m-%d')
                   THEN o.userID END)                          AS returning_customers
              FROM Orders o
              JOIN first_order fo ON fo.userID = o.userID
              WHERE YEAR(o.orderDate) = :year
              GROUP BY month
              ORDER BY month
            """, nativeQuery = true)
    List<Object[]> findCustomerGrowth(@Param("year") int year);

    @Query(value = """
              SELECT
                o.userID,
                DATE_FORMAT(o.orderDate, '%Y-%m') AS month
              FROM Orders o
              WHERE YEAR(o.orderDate) = :year
            """, nativeQuery = true)
    List<Object[]> findMonthlyUsers(@Param("year") int year);

    @Query(value = """
            SELECT AVG(customer_total) FROM (
              SELECT SUM(o.total) AS customer_total
              FROM Orders o
              WHERE YEAR(o.orderDate) = :year
              GROUP BY o.userID
            ) t
            """, nativeQuery = true)
    Double findAvgCustomerLifetimeValue(@Param("year") int year);

    @Query(value = """
            SELECT ROUND(
              SUM(CASE WHEN t.order_count >= 2 THEN 1 ELSE 0 END) * 100.0
              / COUNT(*)
            , 1)
            FROM (
              SELECT userID, COUNT(*) AS order_count
              FROM Orders
              WHERE YEAR(orderDate) = :year
              GROUP BY userID
            ) t
            """, nativeQuery = true)
    Double findRepeatPurchaseRate(@Param("year") int year);
    List<Order> findByPaymentMethodAndStatusAndOrderDateBefore(
            PaymentMethod paymentMethod,
            OrderStatus status,
            LocalDate date
    );

}

package com.example.minishop.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Accessors(chain = true)
public class OrderDetail {
    // 고유번호
    private int id;

    // 주문 고유번호
    private int orderId;

    // 상품 고유번호
    private int productId;

    // 상품 수량
    private int productQuantity;

    // 상품 색상
    private String productColor;

    // 상품 사이즈
    private String productSize;

    // 총액
    private int totalPrice;

    // 상품
    private Product product;
}

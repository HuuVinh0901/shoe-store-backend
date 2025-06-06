package com.shoestore.Server.mapper;
import com.shoestore.Server.dto.request.OrderHistoryStatusDTO;
import com.shoestore.Server.dto.response.OrderStatusHistoryResponse;
import com.shoestore.Server.entities.OrderStatusHistory;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface OrderStatusHistoryMapper {
    OrderStatusHistory toEntity(OrderHistoryStatusDTO dto);
    List<OrderStatusHistoryResponse> toListResponse(List<OrderStatusHistory> entity);
}

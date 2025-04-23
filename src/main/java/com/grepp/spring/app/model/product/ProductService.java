package com.grepp.spring.app.model.product;

import com.grepp.spring.app.model.product.dto.OrderListDto;
import com.grepp.spring.app.model.product.dto.OrderListDto.ProductItemDTO;
import com.grepp.spring.app.model.product.dto.OrderProductDto;
import com.grepp.spring.app.model.product.dto.ProductDto;
import com.grepp.spring.app.model.product.dto.ProductImg;
import com.grepp.spring.infra.error.exceptions.CommonException;
import com.grepp.spring.infra.response.ResponseCode;
import com.grepp.spring.infra.util.file.FileDto;
import com.grepp.spring.infra.util.file.FileUtil;
import java.io.IOException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductService {

    private final ProductRepository productRepository;
    private final FileUtil fileUtil;

    @Transactional
    public List<ProductDto> selectAll() {
        return productRepository.selectAll();
    }

    @Transactional
    public void registProduct(List<MultipartFile> thumbnail, ProductDto dto) {
        try {
            List<FileDto> fileDtos = fileUtil.upload(thumbnail, "product");
            productRepository.insert(dto);

            if (fileDtos.isEmpty()) {
                return;
            }

            ProductImg productImg = new ProductImg(dto.getId(), fileDtos.getFirst());

            productRepository.insertImage(productImg);
        } catch (IOException e) {
            throw new CommonException(ResponseCode.INTERNAL_SERVER_ERROR, e);
        }
    }

    @Transactional
    public boolean deleteById(Integer id) {

        return productRepository.deleteById(id);
    }

    // 비회원 구매
    @Transactional
    public void purchaseProduct(OrderListDto dto) {
        for (ProductItemDTO item : dto.getItems()) {
            OrderListDto nonMember = new OrderListDto();
            OrderProductDto product = new OrderProductDto();

            nonMember.setAddress(dto.getAddress());
            nonMember.setEmail(dto.getEmail());
            nonMember.setCreatedAt(dto.getCreatedAt());
            nonMember.setAddressNumber(dto.getAddressNumber());
            nonMember.setItems(List.of(item));
            nonMember.setIsMember(false);

            productRepository.insertPurchase(nonMember);


            product.setOrderId(nonMember.getId()); // Set the valid order ID
            product.setProductId(item.getId());
            product.setAmount(item.getAmount());

            productRepository.insertOrderProduct(product);
        }
    }
}

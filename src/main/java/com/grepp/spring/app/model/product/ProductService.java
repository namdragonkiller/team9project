package com.grepp.spring.app.model.product;

import com.grepp.spring.app.model.product.dto.OrderDto;
import com.grepp.spring.app.model.product.dto.OrderDto.ProductItemDTO;
import com.grepp.spring.app.model.product.dto.OrderProductDto;
import com.grepp.spring.app.model.product.dto.ProductDto;
import com.grepp.spring.app.model.product.dto.ProductImg;
import com.grepp.spring.infra.error.exceptions.CommonException;
import com.grepp.spring.infra.response.ResponseCode;
import com.grepp.spring.infra.util.file.FileDto;
import com.grepp.spring.infra.util.file.FileUtil;

import java.io.IOException;
import java.time.LocalTime;
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
    public boolean deleteById(Integer id, String path) {
        try {
            boolean result = productRepository.deleteById(id);
            fileUtil.delete(path);
            return result;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


    @Transactional
    public int purchaseProduct(OrderDto dto) {
        OrderDto nonMember = new OrderDto();
        LocalTime now = LocalTime.now();

        // 총 갯수 계산
        int totalAmount = dto.getItems().stream()
            .mapToInt(ProductItemDTO::getAmount)
            .sum();

        // 총 금액 계산
        int totalPrice = dto.getItems().stream()
            .mapToInt(item -> item.getPrice() * item.getAmount())
            .sum();

        nonMember.setAddress(dto.getAddress());
        nonMember.setEmail(dto.getEmail());
        nonMember.setCreatedAt(dto.getCreatedAt());
        nonMember.setAddressNumber(dto.getAddressNumber());
        nonMember.setItems(dto.getItems());
        nonMember.setUserId(dto.getUserId());
        nonMember.setIsMember(dto.getUserId() != null);
        nonMember.setTotalPrice(totalPrice);
        nonMember.setTotalAmount(totalAmount);

        // 시간 체크해서 오후 2시 넘었으면 최초 데이터에 update
//        if (now.isAfter(LocalTime.of(14, 0))) {
//            productRepository.updateOrderList(nonMember);
//        } else {
//            productRepository.insertPurchase(nonMember);
//        }
        productRepository.insertPurchase(nonMember);

        for (ProductItemDTO item : dto.getItems()) {
            OrderProductDto product = new OrderProductDto();
            product.setOrderId(nonMember.getId());
            product.setProductId(item.getId());
            product.setAmount(item.getAmount());
            product.setName(item.getName());
            productRepository.insertOrderProduct(product);

            // 재고 수량 체크 추가
            int stock = productRepository.selectProductAmountById(item.getId()); // 현재 재고 가져오기
            if (stock < item.getAmount()) {
                int nonstock = 0;
                return nonstock;
            }

            // 재고 차감
            productRepository.updateProductAmountById(item.getId(), item.getAmount());
        }
        return 1;
    }


    public ProductDto selectById(Integer id) {
        return productRepository.selectById(id);
    }

    @Transactional
    public void updateById(Integer id, String oldPath, List<MultipartFile> newImage, ProductDto dto) {
        try {
            productRepository.updateProductById(id, dto);


            if (!oldPath.isBlank()){
                List<FileDto> fileDtos = fileUtil.upload(newImage, "product");
                if (fileDtos.isEmpty()) {
                    return;
                }
                ProductImg productImg = new ProductImg(id, fileDtos.getFirst());
                productRepository.updateImageById(productImg);
                fileUtil.delete(oldPath);
            }
        } catch (IOException e) {
            throw new CommonException(ResponseCode.INTERNAL_SERVER_ERROR, e);
        }

    }

    public List<ProductDto> getProducts(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return productRepository.findProducts(offset, pageSize);
    }

    public int countProducts() {
        return productRepository.countProducts();
    }
}

function openModal(product) {
    document.getElementById('modalProductName').textContent = product.name;
    document.getElementById('modalProductImage').src = product.image;
    document.getElementById('modalProductInfo').textContent = product.info;
    document.getElementById('modalProductPrice').textContent = product.price.toLocaleString() + '원';

    const modal = document.getElementById('productModal');
    const background = document.getElementById('modalBackground');

    modal.style.display = 'block';
    background.style.display = 'block';

    void modal.offsetWidth;
    void background.offsetWidth;

    modal.style.opacity = '1';
    modal.style.transform = 'translate(-50%, -50%) scale(1)';
    background.style.opacity = '1';

    document.body.style.overflow = 'hidden';
}

function closeModal() {
    const modal = document.getElementById('productModal');
    const background = document.getElementById('modalBackground');

    modal.style.opacity = '0';
    modal.style.transform = 'translate(-50%, -50%) scale(0.8)';
    background.style.opacity = '0';

    setTimeout(() => {
        modal.style.display = 'none';
        background.style.display = 'none';
    }, 300);

    document.body.style.overflow = 'auto';
}

document.addEventListener('click', function(e) {
    //  장바구니 버튼 클릭
    const addCartButton = e.target.closest('.add-cart');
    if (addCartButton) {
        e.stopPropagation(); // 장바구니 버튼 클릭 시 카드 클릭 막기
        return;
    }
    // 카드 클릭
    const card = e.target.closest('.card');
    if (card) {
        const name = card.dataset.name;
        const image = card.dataset.image;
        const info = card.dataset.info;
        const price = parseInt(card.dataset.price, 10);

        openModal({ name, image, info, price });
    }
});
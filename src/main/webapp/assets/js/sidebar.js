const cartMap = new Map();
const cartItems = document.getElementById("cartItems");
const cartFormInputs = document.getElementById("cartFormInputs");
const cartCountSpan = document.getElementById("cartCount");

let itemIndex = 0;

document.addEventListener("click", function (e) {
    const target = e.target.closest(".add-cart");
    if (!target) return;

    const card = target.closest(".card");
    const name = card.querySelector(".card-title").textContent;
    const priceText = card.querySelector(".price p").textContent;
    const price = parseInt(priceText.replace(/[^0-9]/g, ""), 10);
    const id = card.querySelector('input[name="id"]').value;
    const imageUrl = card.querySelector(".card-image img").src;

    if (cartMap.has(name)) {
        const item = cartMap.get(name);
        item.amount += 1;
        item.totalPrice += price;
        item.element.textContent = `${name} (${item.amount}개) - ${item.totalPrice.toLocaleString()}원`;

        item.inputAmount.value = item.amount;
        item.inputPrice.value = item.totalPrice;
    } else {
        const li = document.createElement("li");
        li.className = "collection-item";
        li.textContent = `${name} (1개) - ${price.toLocaleString()}원`;
        cartItems.appendChild(li);

        const inputId = document.createElement("input");
        inputId.type = "hidden";
        inputId.name = `items[${itemIndex}].id`;
        inputId.value = id;
        cartFormInputs.appendChild(inputId);

        const inputName = document.createElement("input");
        inputName.type = "hidden";
        inputName.name = `items[${itemIndex}].name`;
        inputName.value = name;

        const inputAmount = document.createElement("input");
        inputAmount.type = "hidden";
        inputAmount.name = `items[${itemIndex}].amount`;
        inputAmount.value = 1;

        const inputPrice = document.createElement("input");
        inputPrice.type = "hidden";
        inputPrice.name = `items[${itemIndex}].price`;
        inputPrice.value = price;

        const inputImageUrl = document.createElement("input");
        inputImageUrl.type = "hidden";
        inputImageUrl.name = `items[${itemIndex}].imageUrl`;
        inputImageUrl.value = imageUrl;

        cartFormInputs.appendChild(inputName);
        cartFormInputs.appendChild(inputAmount);
        cartFormInputs.appendChild(inputPrice);
        cartFormInputs.appendChild(inputImageUrl);

        cartMap.set(name, {
            amount: 1,
            totalPrice: price,
            element: li,
            inputAmount: inputAmount,
            inputPrice: inputPrice,
            inputImageUrl: inputImageUrl
        });

        itemIndex++;
    }

    cartCountSpan.textContent = +cartCountSpan.textContent + 1;
});

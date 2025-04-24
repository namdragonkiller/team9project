const cartMap = new Map();
const cartItems = document.getElementById("cartItems");
const cartCountSpan = document.getElementById("cartCount");
const cartFormInputs = document.getElementById("cartFormInputs");

document.addEventListener("click", function (e) {
    const target = e.target.closest(".add-cart");
    if (!target) return;

    const card = target.closest(".card");
    const name = card.querySelector(".card-title").textContent;
    const priceText = card.querySelector(".price p").textContent;
    const price = parseInt(priceText.replace(/[^0-9]/g, ""), 10);

    if (cartMap.has(name)) {
        const item = cartMap.get(name);
        item.count += 1;
        item.totalPrice += price;

        item.element.textContent = `${name} (${item.count}개) - ${item.totalPrice.toLocaleString()}원`;

        item.inputCount.value = item.count;
        item.inputPrice.value = item.totalPrice;
    } else {
        const li = document.createElement("li");
        li.className = "collection-item";
        li.textContent = `${name} (1개) - ${price.toLocaleString()}원`;
        cartItems.appendChild(li);

        const inputName = document.createElement("input");
        inputName.type = "hidden";
        inputName.name = "items[][name]";
        inputName.value = name;

        const inputCount = document.createElement("input");
        inputCount.type = "hidden";
        inputCount.name = "items[][count]";
        inputCount.value = 1;

        const inputPrice = document.createElement("input");
        inputPrice.type = "hidden";
        inputPrice.name = "items[][totalPrice]";
        inputPrice.value = price;

        cartFormInputs.appendChild(inputName);
        cartFormInputs.appendChild(inputCount);
        cartFormInputs.appendChild(inputPrice);

        cartMap.set(name, {
            count: 1,
            totalPrice: price,
            element: li,
            inputCount: inputCount,
            inputPrice: inputPrice
        });
    }

    cartCountSpan.textContent = +cartCountSpan.textContent + 1;
});

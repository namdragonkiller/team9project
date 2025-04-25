const summaryItems = {}; // 상품명: { count, price, id }
const summaryContainer = document.getElementById('summary-items');
const hiddenFieldsContainer = document.getElementById('hidden-fields');

document.querySelectorAll('.products .action button').forEach((button, index) => {
  button.addEventListener('click', () => {
    const itemElement = button.closest('li');
    const name = itemElement.querySelector('.row:nth-child(2)').textContent.trim();
    const price = parseInt(itemElement.querySelector('.price').textContent.trim().replace(/[^0-9]/g, ''));
    const id = itemElement.querySelector('input[name="id"]').value;

    if (summaryItems[name]) {
      summaryItems[name].count += 1;
    } else {
      summaryItems[name] = { count: 1, price, id };
    }

    updateSummary();
  });
});

function updateSummary() {
  summaryContainer.innerHTML = '';
  hiddenFieldsContainer.innerHTML = '';
  let total = 0;
  let index = 0;

  for (const [name, data] of Object.entries(summaryItems)) {
    const itemRow = document.createElement('div');
    itemRow.className = 'row';
    itemRow.innerHTML = `<h6 class="p-0">${name} <span class="badge bg-dark">${data.count}개</span></h6>`;
    summaryContainer.appendChild(itemRow);

    total += data.price * data.count;

    // 이름에 인덱스를 붙여서 전송해야 Spring에서 List로 매핑됨!
    const idInput = `<input type="hidden" name="items[${index}].id" value="${data.id}">`;
    const amountInput = `<input type="hidden" name="items[${index}].amount" value="${data.count}">`;
    const priceInput = `<input type="hidden" name="items[${index}].price" value="${data.price}">`;

    hiddenFieldsContainer.innerHTML += idInput + amountInput + priceInput;

    index++;
  }

  document.querySelector('.summary .border-top h5.text-end').textContent = `${total.toLocaleString()}원`;
}


document.addEventListener('DOMContentLoaded', function() {
  const csrfTokenInput = document.querySelector('[name="${_csrf.parameterName}"]');

  if (!csrfTokenInput) {
    console.error("CSRF token input not found");
    return;
  }

  const csrfToken = csrfTokenInput.value;

  document.getElementById('purchase-form').addEventListener('submit', function(e) {
    e.preventDefault();  // 폼의 기본 제출 동작을 막음

    const email = document.getElementById('email').value;
    const address = document.getElementById('address').value;
    const addressNumber = document.getElementById('addressNumber').value;
    const items = [];

    document.querySelectorAll('#hidden-fields input').forEach(input => {
      const name = input.name.match(/\[([^\]]+)\]/)[1];  // 'items' 이름 추출
      const value = input.value;

      if (name.includes('id')) {
        items.push({ id: value });
      } else if (name.includes('amount')) {
        items[items.length - 1].amount = value;  // 마지막 항목에 amount 추가
      } else if (name.includes('price')) {
        items[items.length - 1].price = value;  // 마지막 항목에 price 추가
      }
    });

    const payload = {
      email,
      address,
      addressNumber,
      items
    };

    const formData = new URLSearchParams();
    formData.append('email', email);
    formData.append('address', address);
    formData.append('addressNumber', addressNumber);
    items.forEach((item, index) => {
      formData.append(`items[${index}].id`, item.id);
      formData.append(`items[${index}].amount`, item.amount);
      formData.append(`items[${index}].price`, item.price);
    });

    fetch('/product/purchase', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-CSRF-TOKEN': csrfToken
      },
      body: formData.toString()
    })
    .then(response => response.json())
    .then(data => {
      // 성공 시 처리
      if (data.success) {
        alert('결제가 완료되었습니다.');
        window.location.href = '/success';  // 성공 페이지로 이동
      } else {
        alert('결제 실패');
      }
    })
    .catch(error => {
      alert('서버와 통신 오류');
      console.error(error);
    });
  });
});

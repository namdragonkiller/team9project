const summaryItems = {};
const summaryContainer = document.getElementById('summary-items');
const hiddenFieldsContainer = document.getElementById('hidden-fields');

// 모든 action 버튼에 이벤트 부여
document.querySelectorAll('.products .action button').forEach((button) => {
  button.addEventListener('click', () => {
    const itemElement = button.closest('li');
    const name = itemElement.querySelector(
        '.row:nth-child(2)').textContent.trim();
    const price = parseInt(
        itemElement.querySelector('.price').textContent.trim().replace(
            /[^0-9]/g, ''));

    const id = itemElement.querySelector('input[name="id"]').value;

    // 현재 수량 표시 요소
    const amountElem = itemElement.querySelector('.col-3');
    let currentAmount = parseInt(
        amountElem.textContent.trim().replace(/[^0-9]/g, '')) || 0;

    // 새로운 항목 추가
    if (!summaryItems[name]) {
      summaryItems[name] = {count: currentAmount, price, id};
    }

    // 'data-action'을 이용해 버튼 동작 구분
    if (button.getAttribute('data-action') === 'plus') {
      summaryItems[name].count += 1;
    } else if (button.getAttribute('data-action') === 'minus') {
      summaryItems[name].count -= 1;
      if (summaryItems[name].count <= 0) {
        delete summaryItems[name];
      }
    }

    updateSummary();
    updateItemDisplay(name, itemElement);
  });
});

function updateItemDisplay(name, itemElement) {
  // 수량이 사라졌으면 해당 항목을 숨김
  if (!summaryItems[name]) {
    itemElement.remove();
  } else {
    const count = summaryItems[name].count;
    const amountElem = itemElement.querySelector('.col-3');
    amountElem.textContent = `${count}개`;

    // 가격과 수량이 변경되면 동적으로 갱신
    const priceElem = itemElement.querySelector('.col.text-center.price');
    priceElem.textContent = `${summaryItems[name].price} 원`;
  }
}

function updateSummary() {
  summaryContainer.innerHTML = '';
  hiddenFieldsContainer.innerHTML = '';
  let total = 0;
  let index = 0;

  for (const [name, data] of Object.entries(summaryItems)) {
    /* 요약 */
    // const itemRow = document.createElement('div');
    // itemRow.className = 'row';
    // itemRow.innerHTML = `<h6 class="p-0">${name} <span class="badge bg-dark">${data.count}개</span></h6>`;
    // summaryContainer.appendChild(itemRow);

    total += data.price * data.count;

    // 이름에 인덱스를 붙여서 전송해야 Spring에서 List로 매핑됨!
    const idInput = `<input type="hidden" name="items[${index}].id" value="${data.id}">`;
    const amountInput = `<input type="hidden" name="items[${index}].amount" value="${data.count}">`;
    const priceInput = `<input type="hidden" name="items[${index}].price" value="${data.price}">`;
    const nameInput = `<input type="hidden" name="items[${index}].name" value="${data.name}">`;

    hiddenFieldsContainer.innerHTML += idInput + amountInput + priceInput + nameInput;

    index++;
  }

  document.querySelector(
      '.summary .border-top h5.text-end').textContent = `${total.toLocaleString()}원`;
}

// 결제 폼 제출 처리
document.addEventListener('DOMContentLoaded', function () {
  // 1. 초기 렌더된 상품 데이터를 summaryItems에 담는다
  document.querySelectorAll('.products li').forEach(itemElement => {
    const name = itemElement.querySelector(
        '.row:nth-child(2)').textContent.trim();
    const price = parseInt(
        itemElement.querySelector('.col.text-center.price').textContent.replace(
            /[^0-9]/g, ''));
    const id = itemElement.querySelector('input[name="id"]').value;
    const count = parseInt(
        itemElement.querySelector('.col-3').textContent.replace(/[^0-9]/g, ''));

    summaryItems[name] = {count, price, id, name};
  });

  // 2. 초기 총금액 계산 + UI 반영
  updateSummary();
});

document.getElementById('purchase-form').addEventListener('submit',
    function (e) {
      e.preventDefault();  // 폼의 기본 제출 동작을 막음

      const email = document.getElementById('email').value;
      const address = document.getElementById('address').value;
      const addressNumber = document.getElementById('addressNumber').value;
      const items = [];
      const errorElement1 = document.querySelector('.red.email');
      const errorElement2 = document.querySelector('.red.address');
      const errorElement3 = document.querySelector('.red.addressNumber');

      if(errorElement1) {
        if (!email) {
            errorElement1.style.display = 'block';
          return;
        } else {
          errorElement1.style.display = 'none';
        }
      }
      if (!address) {
        if (errorElement2) {
          errorElement2.style.display = 'block';
        }
        return;
      }else {
        errorElement2.style.display = 'none';
      }
      if (!addressNumber) {
        if (errorElement3) {
          errorElement3.style.display = 'block';
        }
        return;
      }else {
        errorElement3.style.display = 'none';
      }


      document.querySelectorAll('#hidden-fields input').forEach(input => {
        const name = input.name.match(/\[([^\]]+)\]/)[1];  // 'items' 이름 추출
        const value = input.value;


        if (input.name.includes('id')) {
          items.push({id: value});
        } else if (input.name.includes('amount')) {
          items[items.length - 1].amount = value;  // 마지막 항목에 amount 추가
        } else if (input.name.includes('price')) {
          items[items.length - 1].price = value;  // 마지막 항목에 price 추가
        } else if (input.name.includes('name')) {
          items[items.length - 1].name = value;  // 마지막 항목에 name 추가
        }
      });

      const csrfToken = document.querySelector(
          'meta[name="_csrf"]').getAttribute('content');
      const csrfHeader = document.querySelector(
          'meta[name="_csrf_header"]').getAttribute('content');

      if (!items || items.length === 0) {
        alert("장바구니가 비었습니다.")
        return;
      }

      const formData = new URLSearchParams();
      formData.append('email', email);
      formData.append('address', address);
      formData.append('addressNumber', addressNumber);
      items.forEach((item, index) => {
        formData.append(`items[${index}].id`, item.id);
        formData.append(`items[${index}].amount`, item.amount);
        formData.append(`items[${index}].price`, item.price);
        formData.append(`items[${index}].name`, item.name);
      });

      // Ajax 요청 보내기 (fetch API 사용)
      fetch('/product/purchase', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          [csrfHeader]: csrfToken
        },
        body: formData.toString()
      })
      .then(response => response.json())
      .then(data => {
        if(data.msg === 0) {
          alert("재고가 없습니다.");
          return;
        }

        if (data.success) {
          const now = new Date();
          const currentHour = now.getHours();
          const currentTime = now.toLocaleTimeString();
          if (currentHour >= 14) {  // 14시는 2PM (24시간 기준)
            alert("현재시간은 " + currentTime + " 으로 다음날 배송을 시작합니다.");
          } else {
            alert("현재시간은 " + currentTime + " 으로 당일 배송을 시작합니다.");
          }
          alert('결제 완료되었습니다.');
          window.location.href = '/';  // 메인페이지로 이동
        } else {
          alert(data.errors.join("\n"));
        }
      })
      .catch(error => {
        alert(error.message);
        console.error(error);
      });
    });

const summaryItems = {}; // 상품명: 수량
const summaryContainer = document.getElementById('summary-items');

document.querySelectorAll('.products .action button').forEach(
    (button, index) => {
      button.addEventListener('click', () => {
        const itemElement = button.closest('li');
        const name = itemElement.querySelector(
            '.row:nth-child(2)').textContent.trim();
        const price = parseInt(
            itemElement.querySelector('.price').textContent.trim().replace(
                /[^0-9]/g, ''));

        // 수량 증가
        if (summaryItems[name]) {
          summaryItems[name].count += 1;
        } else {
          summaryItems[name] = {count: 1, price};
        }

        updateSummary();
      });
    });

function updateSummary() {
  summaryContainer.innerHTML = '';
  let total = 0;

  for (const [name, data] of Object.entries(summaryItems)) {
    const itemRow = document.createElement('div');
    itemRow.className = 'row';
    itemRow.innerHTML = `
        <h6 class="p-0">${name} <span class="badge bg-dark">${data.count}개</span></h6>
      `;
    summaryContainer.appendChild(itemRow);
    total += data.price * data.count;
  }

  document.querySelector(
      '.summary .border-top h5.text-end').textContent = `${total.toLocaleString()}원`;
}
function post() {
  const price = document.getElementById("item-price");
  const price_tax = document.getElementById("add-tax-price");
  const price_profit = document.getElementById("profit");

  function add() {
    const price_tax_value = Math.floor(price.value * 0.1);
    const price_profit_value = price.value - price_tax_value;
    price_tax.innerHTML = price_tax_value;
    price_profit.innerHTML = price_profit_value;
  }
  if (price.value != "") {
    add();
  }

  price.addEventListener("input", add);
}

window.addEventListener("load", post);

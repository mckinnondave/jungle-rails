describe('Adding to cart', () => {
  
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("Should click Add and add product to cart. Cart increases by 1.", () => {
    cy.get(".button_to button.btn").click({force: true});
    cy.get(".cart-size .nav-link").contains("My Cart (1)");
  });

});
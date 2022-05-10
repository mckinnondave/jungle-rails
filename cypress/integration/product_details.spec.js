describe('example to-do app', () => {
  
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("Should redirect to product page by clicking on a product", () => {
    cy.get("article").first().click();
  });

});
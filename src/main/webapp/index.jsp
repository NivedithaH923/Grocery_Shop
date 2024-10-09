<%@ page import="java.util.*"%>
<%@ page import="grocery_dao.ProductDao"%>
<%@ page import="grocery_connection.DbCon"%>
<%@ page import="grocery_model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("auth", auth);
}

ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();

ArrayList<Cart> cart_list=(ArrayList<Cart>) session.getAttribute("cart-list");

if(cart_list!=null){
    request.setAttribute("cart_list",cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Welcome to Grocery Store!!</title>
<%@include file="includes/head.jsp"%>
<style>
/* Ensure all product cards are the same size */
.card-w-100 {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    height: 100%; /* Ensure full height */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    overflow: hidden;
    transition: transform 0.3s ease;
}

.card-w-100 img {
    height: 200px; /* Set a fixed height for the product image */
    object-fit: cover; /* Ensure the image fits nicely */
    width: 100%; /* Full width */
}

.card-body {
    flex-grow: 1;
    padding: 15px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.card-title {
    font-size: 18px;
    margin-bottom: 10px;
    text-align: center;
}

.price, .category {
    font-size: 16px;
    margin-bottom: 5px;
    text-align: center;
}

.card-body .mt-3 {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.btn {
    width: 48%; /* Ensure buttons are the same width */
}

.card-w-100:hover {
    transform: scale(1.05); /* Slightly enlarge on hover */
}
</style>
</head>
<body>

    <%@include file="includes/navbar.jsp"%>

    <div class="container">
        <div class="card-header my-3">All Products</div>
        <div class="row">
            <%
            if (!products.isEmpty()) {
                for (Product p : products) {%>
                    <div class="col-md-3 my-3">
                        <div class="card-w-100">
                            <img class="card-img-top" src="product-image/<%= p.getImage() %>" alt="Product image">
                            <div class="card-body">
                                <h5 class="card-title"><%= p.getName() %></h5>
                                <h6 class="price">Price: $<%= p.getPrice() %></h6>
                                <h6 class="category">Category: <%= p.getCategory() %></h6>
                                <div class="mt-3 d-flex justify-content-between">
                                    <a href="add-to-cart?id=<%= p.getId() %>" class="btn btn-dark">Add to Cart</a>
                                    <a href="order-now?quantity=1&id=<%= p.getId() %>" class="btn btn-primary">Buy Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                <%}
            }
            %>
        </div>
    </div>

    <%@include file="includes/footer.jsp"%>
</body>
</html>

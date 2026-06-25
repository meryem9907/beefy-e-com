# Description
- In order to raise the popularity of bees among the communities the e-commerce website is specialized to promote vendours selling
bee-related commodities.
- It gives beefarmers and related sellers the oppurtinity to sell their products and keep their bee-farm thriving
- The project allows sellers to spread their products without building their own webpage and they can easily connect to a logistics company with an automated workflow.

# Scope
1. Must-have
- Customers can buy bee-products with a payment workflow
- Customers can get the product delivered
- Custommers can browse through the categories
- Customers can see a detailed view of the product
- Sellers can put their products to sale
- Sellers can login/sign in
2. Nice-to-have
- Customers can write comments to a product
- Customers can score a product
3. Optional
- admin interface

# Specification
1. Functional
- as a customer i want to search all the products by category so i can find certain things faster. Dropdown with categories as links.
- as a customer i want to filter the products by vendour, price, Best sellers, New arrivals. Filter button filters the products.
- as a vendour i want to sell my products by the categories: honey, bee supplements, skincare&beauty, candles&home, food&pantry, gift sets, Beekeeping Supplies. When rolling out a new product the seller should be able to chose these categories via dropdown.
- as a vendour i want to add and edit following attributes about my product: photo, category, price, short description, ingredients, measurements (weight, volume, measures, amount), custom attributes. Vendour can view all of their products in a dashboard, add new products and edit them.
- as a vendour i want to chose a logistics workflow. The company can chose a logistics workflow. Each workflow has a contract, packaging guidelines, cost program and a pick-up schedule.
- as customer i want to purchase the products by credit-cart. The user needs to provide their credit cart informations when buying a product.
- as a customer i want to track my purchases so i can see when they arrive. The purchased goods can be viewed in a list with a delivery status (approved, packing, in delivery)
- as a customer i want to add products to the cart
- as a vendour i want to update the packing/shipping status
- as a vendor i want view own orders
- as a vendor i wanto see the vendor dashboard
2. Not-Functional
- as a developer i want to design the page using a yellow, brown and black colour schema and the ui elements should resemble bees, wables and honey jars.
- as a developer i want the page to be accessible. The lighthouse score for each page should be 100%
- as a developer i want a secure and reliable purchase workflow. Use Message Queues to send long running tasks to background and send a confirmation email if purchase was successful to customer.
- as a developer i want to differ between the roles vendour and buyer. The login/signup mask should allow two choices and the ui elements are adjusted to the permissions of the roles. 
3. Constraints
- Frontend: Next.js + React + TypeScript
- Backend: Java Spring Boot
- Database: PostgreSQL
- ORM: Spring Data JPA / Hibernate
- Security: Spring Security + JWT or OAuth2
- Payments: Stripe / Stripe Connect
- Storage: S3 or Cloudflare R2
- Search: PostgreSQL full-text first, Elasticsearch/OpenSearch later
- Messaging/jobs: RabbitMQ, Kafka, SQS
- Deployment: Docker + AWS ECS/Fargate, Render, Railway, or Fly.io

# MVP 
General: 
For MQ:
Customer pays
-> backend updates order to paid
-> backend publishes OrderPaid event
-> response succeeds
Worker later:
-> sends email
-> notifies vendor
-> creates shipment
-> retries if something fails

# Sprints
1. 24.06 - 01.07
- collect inspo for design choices
- Create a design in figma
- init repo and create project boilerplate
- create data model
2. 02.07 - 08.07
- implement frontend
3. 08.07 - 15.07
- implement backend
4. 15.07 - 22.07 
- test and deploy 

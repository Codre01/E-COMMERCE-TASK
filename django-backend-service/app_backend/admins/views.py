from rest_framework import generics, status
from core import models, serializers
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from django.shortcuts import get_object_or_404
from django.db.models import Count
from django.utils import timezone
from datetime import datetime, timedelta
from order import models as order_models, serializers as order_serializers
import random

class ProductList(generics.ListCreateAPIView):
    serializer_class = serializers.ProductSerializer
    queryset = models.Product.objects.all()
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        page = self.request.query_params.get('page', 1)
        limit = 20
        offset = (int(page) - 1) * limit
        
        queryset = models.Product.objects.all()
        queryset = queryset.annotate(product_count=Count('id'))
        queryset = list(queryset)
        
        random.shuffle(queryset)
        
        return queryset[offset:offset + limit]


class CreateProduct(generics.CreateAPIView):
    queryset = models.Product.objects.all()
    serializer_class = serializers.ProductSerializer
    permission_classes = [IsAdminUser]

    def create(self, request, *args, **kwargs):
        try:
            data = {
                "title": request.data.get("title"),
                "price": float(request.data.get("price", 0.0)),
                "description": request.data.get("description"),
                "is_featured": request.data.get("is_featured", False),
                "clothes_type": request.data.get("clothes_type", "unisex"),
                "rating": float(request.data.get("rating", 1.0)),
                "category": request.data.get("category"),
                "brand": request.data.get("brand"),
                "color": request.data.get("color", []),
                "sizes": request.data.get("sizes", []),
                "image_urls": request.data.get("image_urls", []),
                "created_at": timezone.now()
            }

            serializer = self.get_serializer(data=data)
            if serializer.is_valid():
                serializer.save()
                return Response({
                    "status": "success",
                    "message": "Product created successfully",
                    "data": serializer.data
                }, status=status.HTTP_201_CREATED)
            
            return Response({
                "status": "error",
                "message": "Invalid data provided",
                "errors": serializer.errors
            }, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({
                "status": "error",
                "message": str(e)
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            
class UpdateProduct(generics.UpdateAPIView):
    queryset = models.Product.objects.all()
    serializer_class = serializers.ProductSerializer
    permission_classes = [IsAdminUser]
    lookup_field = 'id'

    def update(self, request, *args, **kwargs):
        try:
            instance = self.get_object()
            data = {
                "title": request.data.get("title", instance.title),
                "price": float(request.data.get("price", instance.price)),
                "description": request.data.get("description", instance.description),
                "is_featured": request.data.get("is_featured", instance.is_featured),
                "clothes_type": request.data.get("clothes_type", instance.clothes_type),
                "rating": float(request.data.get("rating", instance.rating)),
                "category": request.data.get("category", instance.category.id),
                "brand": request.data.get("brand", instance.brand.id),
                "color": request.data.get("color", instance.color),
                "sizes": request.data.get("sizes", instance.sizes),
                "image_urls": request.data.get("image_urls", instance.image_urls)
            }

            serializer = self.get_serializer(instance, data=data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response({
                    "status": "success",
                    "message": "Product updated successfully",
                    "data": serializer.data
                })
            
            return Response({
                "status": "error",
                "message": "Invalid data provided",
                "errors": serializer.errors
            }, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({
                "status": "error",
                "message": str(e)
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class CreateCategory(generics.CreateAPIView):
    queryset = models.Category.objects.all()
    serializer_class = serializers.CategorySerializer
    permission_classes = [IsAdminUser]

    def create(self, request, *args, **kwargs):
        try:
            data = {
                "title": request.data.get("title"),
                "image_url": request.data.get("image_url")
            }

            serializer = self.get_serializer(data=data)
            if serializer.is_valid():
                serializer.save()
                return Response({
                    "status": "success",
                    "message": "Category created successfully",
                    "data": serializer.data
                }, status=status.HTTP_201_CREATED)

            return Response({
                "status": "error",
                "message": "Invalid data provided",
                "errors": serializer.errors
            }, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({
                "status": "error",
                "message": str(e)
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class CreateBrand(generics.CreateAPIView):
    queryset = models.Brand.objects.all()
    serializer_class = serializers.BrandSerializer
    permission_classes = [IsAdminUser]

    def create(self, request, *args, **kwargs):
        try:
            data = {
                "title": request.data.get("title"),
                "image_url": request.data.get("image_url")
            }

            serializer = self.get_serializer(data=data)
            if serializer.is_valid():
                serializer.save()
                return Response({
                    "status": "success",
                    "message": "Brand created successfully",
                    "data": serializer.data
                }, status=status.HTTP_201_CREATED)

            return Response({
                "status": "error",
                "message": "Invalid data provided",
                "errors": serializer.errors
            }, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({
                "status": "error",
                "message": str(e)
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class DeleteProduct(generics.DestroyAPIView):
    queryset = models.Product.objects.all()
    serializer_class = serializers.ProductSerializer
    permission_classes = [IsAdminUser]
    lookup_field = 'id'

    def destroy(self, request, *args, **kwargs):
        try:
            instance = self.get_object()
            instance.delete()
            return Response({
                "status": "success",
                "message": "Product deleted successfully"
            }, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({
                "status": "error",
                "message": str(e)
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class DeleteCategory(generics.DestroyAPIView):
    queryset = models.Category.objects.all()
    serializer_class = serializers.CategorySerializer
    permission_classes = [IsAdminUser]
    lookup_field = 'id'

    def destroy(self, request, *args, **kwargs):
        try:
            instance = self.get_object()
            instance.delete()
            return Response({
                "status": "success",
                "message": "Category deleted successfully"
            }, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({
                "status": "error",
                "message": str(e)
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class DeleteBrand(generics.DestroyAPIView):
    queryset = models.Brand.objects.all()
    serializer_class = serializers.BrandSerializer
    permission_classes = [IsAdminUser]
    lookup_field = 'id'

    def destroy(self, request, *args, **kwargs):
        try:
            instance = self.get_object()
            instance.delete()
            return Response({
                "status": "success",
                "message": "Brand deleted successfully"
            }, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({
                "status": "error",
                "message": str(e)
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class OrderListCreateView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        """Get all orders"""
        if request.user.is_staff:
            orders = order_models.Order.objects.all().prefetch_related('items', 'items__product_id')
        else:
            orders = order_models.Order.objects.filter(user_id=request.user).prefetch_related('items', 'items__product_id')
        
        serializer = order_serializers.OrderSerializer(orders, many=True)
        return Response(serializer.data)

    def post(self, request):
        """Create a new order"""
        serializer = order_serializers.OrderSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user_id=request.user)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class OrderDetailView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, pk):
        """Get specific order details"""
        order = get_object_or_404(order_models.Order, pk=pk)
        if not request.user.is_staff and order.user_id != request.user:
            return Response(status=status.HTTP_403_FORBIDDEN)
            
        serializer = order_serializers.OrderSerializer(order)
        return Response(serializer.data)

    def put(self, request, pk):
        """Update order details"""
        order = get_object_or_404(order_models.Order, pk=pk)
        if not request.user.is_staff and order.user_id != request.user:
            return Response(status=status.HTTP_403_FORBIDDEN)
            
        serializer = order_serializers.OrderSerializer(order, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class OrderStatusUpdateView(APIView):
    permission_classes = [IsAuthenticated]

    def patch(self, request, pk):
        """Update order status"""
        order = get_object_or_404(order_models.Order, pk=pk)
        if not request.user.is_staff:
            return Response(status=status.HTTP_403_FORBIDDEN)

        new_status = request.data.get('status')
        if new_status not in dict(order_models.Order.STATUS_CHOICES):
            return Response(
                {'error': 'Invalid status'},
                status=status.HTTP_400_BAD_REQUEST
            )

        order.status = new_status
        order.save()
        serializer = order_serializers.OrderSerializer(order)
        return Response(serializer.data)

class OrderPaymentStatusUpdateView(APIView):
    permission_classes = [IsAuthenticated]

    def patch(self, request, pk):
        """Update payment status"""
        order = get_object_or_404(order_models.Order, pk=pk)
        if not request.user.is_staff:
            return Response(status=status.HTTP_403_FORBIDDEN)

        new_payment_status = request.data.get('payment_status')
        if new_payment_status not in dict(order_models.Order.PAYMENT_STATUS_CHOICES):
            return Response(
                {'error': 'Invalid payment status'},
                status=status.HTTP_400_BAD_REQUEST
            )

        order.payment_status = new_payment_status
        order.save()
        serializer = order_serializers.OrderSerializer(order)
        return Response(serializer.data)

class RecentOrdersView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        """Get recent orders (last 30 days)"""
        thirty_days_ago = datetime.now() - timedelta(days=30)
        if request.user.is_staff:
            orders = order_models.Order.objects.filter(created_at__gte=thirty_days_ago)
        else:
            orders = order_models.Order.objects.filter(
                user_id=request.user,
                created_at__gte=thirty_days_ago
            )
        
        serializer = order_serializers.OrderSerializer(orders, many=True)
        return Response(serializer.data)

class OrderItemListCreateView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, order_pk):
        """Get all items for a specific order"""
        order = get_object_or_404(order_models.Order, pk=order_pk)
        if not request.user.is_staff and order.user_id != request.user:
            return Response(status=status.HTTP_403_FORBIDDEN)
            
        items = order_models.OrderItem.objects.filter(order_id=order_pk)
        serializer = order_serializers.OrderItemSerializer(items, many=True)
        return Response(serializer.data)

    def post(self, request, order_pk):
        """Create a new order item"""
        order = get_object_or_404(order_models.Order, pk=order_pk)
        if not request.user.is_staff and order.user_id != request.user:
            return Response(status=status.HTTP_403_FORBIDDEN)

        serializer = order_serializers.OrderItemSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(order_id=order)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class OrderItemDetailView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, order_pk, pk):
        """Get specific order item details"""
        order = get_object_or_404(order_models.Order, pk=order_pk)
        if not request.user.is_staff and order.user_id != request.user:
            return Response(status=status.HTTP_403_FORBIDDEN)
            
        item = get_object_or_404(order_models.OrderItem, order_id=order_pk, pk=pk)
        serializer = order_serializers.OrderItemSerializer(item)
        return Response(serializer.data)

    def put(self, request, order_pk, pk):
        """Update order item details"""
        order = get_object_or_404(order_models.Order, pk=order_pk)
        if not request.user.is_staff and order.user_id != request.user:
            return Response(status=status.HTTP_403_FORBIDDEN)
            
        item = get_object_or_404(order_models.OrderItem, order_id=order_pk, pk=pk)
        serializer = order_serializers.OrderItemSerializer(item, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
 
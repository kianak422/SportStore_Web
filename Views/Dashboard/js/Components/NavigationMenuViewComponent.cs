using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace SportStore_Web.Components
{
    // Đảm bảo Controller cho Dashboard đã được tạo
    public class NavigationMenuViewComponent : ViewComponent
    {
        // Hàm InvokeAsync sẽ được gọi khi View Component được render
        public IViewComponentResult Invoke()
        {
            // --- LOGIC PHÂN QUYỀN MOCKUP ---
            // 1. Kiểm tra xem người dùng có được xác thực hay không
            // 2. Kiểm tra xem người dùng có thuộc vai trò "Admin" hay không

            // GIẢ ĐỊNH: Nếu hệ thống đã triển khai Identity/Authentication, 
            // chúng ta sẽ dùng: bool isAdmin = User.IsInRole("Admin");
            
            // Ở đây, chúng ta MOCKUP để luôn hiển thị link cho mục đích phát triển:
            bool isAdmin = true; // Gỡ bỏ dòng này khi triển khai Auth/Identity

            // Truyền thông tin phân quyền này sang View Component's View (Default.cshtml)
            ViewBag.IsAdmin = isAdmin;

            return View();
        }
    }
}
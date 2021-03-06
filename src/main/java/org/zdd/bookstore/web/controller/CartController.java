package org.zdd.bookstore.web.controller;

import com.alibaba.fastjson.JSON;
import org.zdd.bookstore.common.pojo.BSResult;
import org.zdd.bookstore.common.utils.TimeUtils;
import org.zdd.bookstore.exception.BSException;
import org.zdd.bookstore.model.entity.User;
import org.zdd.bookstore.model.entity.custom.Cart;
import org.zdd.bookstore.model.entity.BookInfo;
import org.zdd.bookstore.model.entity.log.ShoppingLogs;
import org.zdd.bookstore.model.service.HDFSService;
import org.zdd.bookstore.model.service.IBookInfoService;
import org.zdd.bookstore.model.service.ICartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private IBookInfoService bookInfoService;

    @Autowired
    private ICartService cartService;

    //返回购物差页面
    @GetMapping("/items")
    public String showCart() {
        return "cart";
    }

    @Autowired
    HDFSService hdfsService;
    /**
     * 加入购物车
     *
     * @param bookId
     * @param request
     * @return
     */
    @RequestMapping("/addition")
    public String addToCart(@RequestParam(value = "bookId",defaultValue = "0") int bookId,
                            @RequestParam(required = false,defaultValue = "0") int buyNum,
                            HttpServletRequest request) {

        Cart cart = (Cart) request.getSession().getAttribute("cart");
        //根据要加入购物车的bookId查询bookInfo
        BookInfo bookInfo = bookInfoService.queryBookAvailable(bookId);

        if (bookInfo != null) {
            //这本书在数据库里
            BSResult bsResult = cartService.addToCart(bookInfo, cart, buyNum);
            request.getSession().setAttribute("cart", bsResult.getData());
            request.setAttribute("bookInfo", bookInfo);
        } else {
            //数据库里没有这本书,或库存不足
            request.setAttribute("bookInfo", null);
        }
        return "addcart";
    }

    @RequestMapping("/addHDFS")
    public void addToHDFS(int bookId, HttpSession session) throws BSException {

        BookInfo bookInfo = bookInfoService.findById(bookId);

        User user = (User) session.getAttribute("loginUser");

        ShoppingLogs shoppingLogs = new ShoppingLogs(user.getUserId().toString(), user.getUsername(), user.getEmail(), user.getPhone(), user.getLocation(), user.getDetailAddress(), bookInfo.getBookId().toString(), bookInfo.getName(), bookInfo.getPress(), bookInfo.getPrice().toString(), bookInfo.getMarketPrice().toString(), bookInfo.getDealMount().toString(), bookInfo.getLookMount().toString(), TimeUtils.getTimes(), user.getGender(), user.getIdentity());
        String line = JSON.toJSONString(shoppingLogs);
        hdfsService.logToHDFS(line);
    }

    @GetMapping("/clear")
    public String clearCart(HttpServletRequest request) {
        cartService.clearCart(request,"cart");
        return "cart";
    }

    @GetMapping("/deletion/{bookId}")
    public String deleteCartItem(@PathVariable("bookId") int bookId,HttpServletRequest request){
        cartService.deleteCartItem(bookId, request);
        return "redirect:/cart/items";
    }

    /**
     * 更新某个购物车项的购买数量
     * @param bookId
     * @param newNum
     * @param request
     * @return
     */
    @PostMapping("/buy/num/update")
    @ResponseBody
    public BSResult updateBuyNum(int bookId, int newNum, HttpServletRequest request){
        return cartService.updateBuyNum(bookId, newNum, request);
    }

    @PostMapping("/checkOne")
    @ResponseBody
    public BSResult checkACartItem(int bookId,HttpServletRequest request){
        Cart cart = (Cart)request.getSession().getAttribute("cart");
        return cartService.checkedOrNot(cart, bookId);
    }
}

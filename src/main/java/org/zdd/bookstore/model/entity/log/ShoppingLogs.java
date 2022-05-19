package org.zdd.bookstore.model.entity.log;

public class ShoppingLogs {
    private String user_id;
    private String username;
    private String email;
    private String phone;
    private String location;
    private String detail_address;
    private String book_id;
    private String book_name;
    private String book_press;
    private String book_price;
    private String book_market_price;
    private String deal_mount;
    private String look_mount;
    private String times;
    private String gender;
    private String identity;


    public ShoppingLogs(String user_id, String username, String email, String phone, String location, String detail_address, String book_id, String book_name, String book_press, String book_price, String book_market_price, String deal_mount, String look_mount, String times, String gender, String identity) {
        this.user_id = user_id;
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.location = location;
        this.detail_address = detail_address;
        this.book_id = book_id;
        this.book_name = book_name;
        this.book_press = book_press;
        this.book_price = book_price;
        this.book_market_price = book_market_price;
        this.deal_mount = deal_mount;
        this.look_mount = look_mount;
        this.times = times;
        this.gender = gender;
        this.identity = identity;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setDetail_address(String detail_address) {
        this.detail_address = detail_address;
    }

    public void setBook_id(String book_id) {
        this.book_id = book_id;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public void setBook_press(String book_press) {
        this.book_press = book_press;
    }

    public void setBook_price(String book_price) {
        this.book_price = book_price;
    }

    public void setBook_market_price(String book_market_price) {
        this.book_market_price = book_market_price;
    }

    public void setDeal_mount(String deal_mount) {
        this.deal_mount = deal_mount;
    }

    public void setLook_mount(String look_mount) {
        this.look_mount = look_mount;
    }

    public void setTimes(String times) {
        this.times = times;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
    }

    public String getUser_id() {
        return user_id;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public String getLocation() {
        return location;
    }

    public String getDetail_address() {
        return detail_address;
    }

    public String getBook_id() {
        return book_id;
    }

    public String getBook_name() {
        return book_name;
    }

    public String getBook_press() {
        return book_press;
    }

    public String getBook_price() {
        return book_price;
    }

    public String getBook_market_price() {
        return book_market_price;
    }

    public String getDeal_mount() {
        return deal_mount;
    }

    public String getLook_mount() {
        return look_mount;
    }

    public String getTimes() {
        return times;
    }

    public String getGender() {
        return gender;
    }

    public String getIdentity() {
        return identity;
    }
}

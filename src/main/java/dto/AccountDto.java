package dto;


import lombok.*;

import java.io.Serializable;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AccountDto implements Serializable{

    private Integer id;
    private String account;
    private String email;
    private String password;
    private Integer status;

    public AccountDto(String account, String email,String password,Integer status) {
        this.account = account;
        this.email = email;
        this.password = password;
        this.status = status;
    }
}

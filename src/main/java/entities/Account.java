package entities;


import lombok.*;
import javax.persistence.*;
import java.io.Serializable;


@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Table(name = "Account",schema = "dbo")
public class Account implements Serializable {

    @Id
    @Column(name = "account_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "account",unique = true)
    private String account;


    @Column(name = "email",unique = true)
    private String email;

    @Column(name = "password")
    private String password;


    @Column(name = "status")
    private Integer status;

    @ToString.Exclude
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "employee_id",referencedColumnName = "employee_id")
    private Employee employee;

}

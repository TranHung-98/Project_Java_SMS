package entities;

import com.google.gson.annotations.SerializedName;
import lombok.*;
import org.hibernate.annotations.Subselect;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Getter
@Setter
@Builder
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Employee",schema = "dbo")
public class Employee {

    @Id
    @Column(name = "employee_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "gender")
    private Integer gender;


    @Column(name = "date_of_birth")
    private LocalDate date;

    @Column(name = "phone",length = 20)
    private String phone;

    @SerializedName("address")
    @Column(name = "address")
    private String address;


    @Column(name = "department")
    private String  department;

    @Column(name = "remark",length = 1000)
    private String remark;

    @OneToOne(mappedBy ="employee",fetch = FetchType.EAGER,cascade = CascadeType.ALL)
    private Account account;

}

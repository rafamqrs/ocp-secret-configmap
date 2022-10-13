package cl.santander.repository;
import org.springframework.data.repository.CrudRepository;

import cl.santander.model.Student;
public interface StudentRepository extends CrudRepository<Student, Integer>
{
}

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLTimeoutException;
import java.sql.Statement;

public class MainClass {
    
    public static void main(String[] args) {
        try {
            Class.forName("org.postgresql.Driver");
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try {
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/studenti");
            
            Statement stm = conn.createStatement();
            
            //request1a(stm);
            request1b(stm);
            stm.close();

            request2a(conn);

            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }

    public static void printQueryResults(ResultSet res) throws SQLException {
        System.out.println("Risultati query:");

        while(res.next()) {
            int matr = res.getInt(1);
            String cognome = res.getString(2);
            String nome = res.getString(3);

            System.out.println(String.format("(%d, %s, %s)", matr, cognome, nome));
        }
    }

    public static void request1(Statement stm) throws SQLException {
        int ret = stm.executeUpdate(
            """
            CREATE TABLE studenti(
                matr int primary key,
                cognome varchar(50),
                nome varchar(50)
            );
            """
        );
        System.out.print("Return code: ");
        System.out.println(ret);

        ret = stm.executeUpdate(
            """
            INSERT INTO studenti(matr, cognome, nome)
            VALUES(1, 'rossi', 'mario');
            """
        );
        ret = stm.executeUpdate(
            """
            INSERT INTO studenti(matr, cognome, nome)
            VALUES(2, 'bianchi', 'sergio');
            """
        );
    }

    public static void request1b(Statement stm) throws SQLException {
        ResultSet res = stm.executeQuery(
            """
            SELECT * FROM studenti;
            """
        );

        printQueryResults(res);

        res.close();
    }

    public static void request2a(Connection conn) throws SQLException {
        PreparedStatement pstm = conn.prepareStatement(
            """
            SELECT * FROM studenti WHERE nome = ? and matr > ?
            """
        );

        pstm.setString(1, "sergio");
        pstm.setInt(2, 0);

        ResultSet res = pstm.executeQuery();

        printQueryResults(res);

        res.close();
    }

}

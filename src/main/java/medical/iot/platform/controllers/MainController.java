package medical.iot.platform.controllers;

import medical.iot.platform.entities.Comment;
import medical.iot.platform.entities.Diagnostic;
import medical.iot.platform.entities.Investigation;
import medical.iot.platform.repositories.CommentRepository;
import medical.iot.platform.repositories.DiagnosticRepository;
import medical.iot.platform.repositories.InvestigationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import medical.iot.platform.entities.User;
import medical.iot.platform.repositories.UserRepository;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

@Controller
public class MainController {
    public static final String SESSION_USER = "SESSION_USER";
    public static final String SESSION_INVESTIGATION = "SESSION_INVESTIGATION";
    public static final String SESSION_INVESTIGATIONS = "SESSION_INVESTIGATIONS";

    private UserRepository userRepository;
    private InvestigationRepository investigationRepository;
    private DiagnosticRepository diagnosticRepository;
    private CommentRepository commentRepository;

    @Autowired
    public MainController(final UserRepository userRepository, final InvestigationRepository investigationRepository,
                          final DiagnosticRepository diagnosticRepository, final CommentRepository commentRepository) {
        this.userRepository = userRepository;
        this.investigationRepository = investigationRepository;
        this.diagnosticRepository = diagnosticRepository;
        this.commentRepository = commentRepository;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String getLogin(HttpServletRequest request) {
        if (isAuthenticated(request)) {
            return getHome(request);
        }
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String postLogin(HttpServletRequest request) {
        if (isAuthenticated(request)) {
            return getHome(request);
        }

        String uniqueId = request.getParameter("uniqueId");
        String password = request.getParameter("password");

        Optional<User> optionalUser = userRepository.findByUniqueId(uniqueId);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            if (user.getPassword().equals(password)) {
                request.getSession().setAttribute(SESSION_USER, user);
                return getHome(request);
            } else {
                return "login";
            }
        } else {
            return "login";
        }
    }

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String getHome(HttpServletRequest request) {
        if (!isAuthenticated(request)) {
            return getLogin(request);
        }
        List<Investigation> investigationList = investigationRepository.findAll();
        request.getSession().setAttribute(SESSION_INVESTIGATIONS, investigationList);
        return "main";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String getlogout(HttpServletRequest request) {
        request.getSession().setAttribute(SESSION_USER, null);
        return getLogin(request);
    }

    @RequestMapping(value = "/addDiagnostic", method = RequestMethod.GET)
    public String getAddDiagnostic(HttpServletRequest request) {
        if (!isAuthenticated(request)) {
            return getLogin(request);
        }

        String idInvestigation = request.getParameter("id");
        long id = Long.parseLong(idInvestigation);

        Optional<Investigation> investigationOptional = investigationRepository.findById(id);
        request.getSession().setAttribute(SESSION_INVESTIGATION, investigationOptional.isPresent() ? investigationOptional.get() : null);

        return "addDiagnostic";
    }

    @RequestMapping(value = "/addDiagnostic", method = RequestMethod.POST)
    public String postAddDiagnostic(HttpServletRequest request) {
        if (!isAuthenticated(request)) {
            return getLogin(request);
        }

        Investigation investigation = (Investigation) request.getSession().getAttribute(SESSION_INVESTIGATION);
        String descriptionDiagnostic = request.getParameter("diagnostic");

        if (investigation != null) {
            if (!StringUtils.isEmpty(descriptionDiagnostic)) {
                Diagnostic diagnostic = Diagnostic.builder()
                        .description(descriptionDiagnostic)
                        .investigation(investigation)
                        .doctor((User) request.getSession().getAttribute(SESSION_USER))
                        .timestamp(new Timestamp(System.currentTimeMillis()))
                        .build();

                diagnosticRepository.save(diagnostic);
            }
        }
        request.getSession().setAttribute(SESSION_INVESTIGATION, null);

        return getHome(request);
    }

    @RequestMapping(value = "/addComment", method = RequestMethod.POST)
    public String postAddComment(HttpServletRequest request) {
        if (!isAuthenticated(request)) {
            return getLogin(request);
        }

        String commentDescription = request.getParameter("comment");
        String id = request.getParameter("diagnosticId");
        Long diagnosticId = Long.parseLong(id);
        Optional<Diagnostic> diagnosticOptional = diagnosticRepository.findById(diagnosticId);

        if (diagnosticOptional.isPresent()) {
            if (!StringUtils.isEmpty(commentDescription)) {
                Comment comment = Comment.builder()
                        .comment(commentDescription)
                        .diagnostic(diagnosticOptional.get())
                        .user((User) request.getSession().getAttribute(SESSION_USER))
                        .timestamp(new Timestamp(System.currentTimeMillis()))
                        .build();
                commentRepository.save(comment);
            }
        }
        Investigation investigation = (Investigation) request.getSession().getAttribute(SESSION_INVESTIGATION);
        investigation = investigationRepository.findById(investigation.getId()).get();
        request.getSession().setAttribute(SESSION_INVESTIGATION, investigation);

        return "addDiagnostic";
    }

    private boolean isAuthenticated(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute(SESSION_USER);
        return user != null;
    }
}

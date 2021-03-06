package ua.com.repairagency.servlet;

import ua.com.repairagency.commands.admin.DeleteCommentCommand;
import ua.com.repairagency.commands.admin.DeleteUserCommand;
import ua.com.repairagency.commands.interfaces.ICommand;
import ua.com.repairagency.commands.loading.LoadAcceptedAppsCommand;
import ua.com.repairagency.commands.loading.LoadApplicationsCommand;
import ua.com.repairagency.commands.loading.LoadCommentsCommand;
import ua.com.repairagency.commands.locale.ChangeLocaleCommand;
import ua.com.repairagency.commands.login.*;
import ua.com.repairagency.commands.registration.SubmitRegistrationCommand;
import ua.com.repairagency.commands.manager.AcceptApplicationCommand;
import ua.com.repairagency.commands.manager.RejectApplicationCommand;
import ua.com.repairagency.commands.missing.MissingCommand;
import ua.com.repairagency.commands.repairman.CompleteOrderCommand;
import ua.com.repairagency.commands.user.EditCommentCommand;
import ua.com.repairagency.commands.user.SubmitApplicationCommand;
import ua.com.repairagency.commands.user.SubmitCommentCommand;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

/** A Singleton helper class for the Controller. */
public class ControllerHelper {

    private static final ControllerHelper instance = new ControllerHelper();
    private final HashMap<String, ICommand> commands = new HashMap<String, ICommand>();

    /** The constructor, it stores the commands in a HashMap. */
    private ControllerHelper() {

        // change locale command
        commands.put("change_locale", new ChangeLocaleCommand());

        // login commands
        commands.put("login", new LoginCommand());
        commands.put("logout", new LogoutCommand());
        commands.put("register", new RegisterCommand());

        // registration command
        commands.put("submit_registration", new SubmitRegistrationCommand());

        // main page command
        commands.put("load_comments", new LoadCommentsCommand());
        commands.put("load_applications", new LoadApplicationsCommand());
        commands.put("load_accepted_apps", new LoadAcceptedAppsCommand());

        // commands available to manager
        commands.put("accept_application", new AcceptApplicationCommand());
        commands.put("reject_application", new RejectApplicationCommand());

        // command available to repairman
        commands.put("complete_order", new CompleteOrderCommand());

        // commands available to user
        commands.put("submit_comment", new SubmitCommentCommand());
        commands.put("edit_comment", new EditCommentCommand());     // optional
        commands.put("submit_application", new SubmitApplicationCommand());

        // commands available to admin
        commands.put("delete_comment", new DeleteCommentCommand()); // optional
        commands.put("delete_user", new DeleteUserCommand());       // optional
    }

    /** Retrieves the command to be executed. */
    public ICommand getCommand(HttpServletRequest request) {
        ICommand command = commands.get(request.getParameter("command"));
        if (command == null) {
            command = new MissingCommand();
        }
        return command;
    }

    /** Thread-safe implementation of Singleton pattern. */
    public static ControllerHelper getInstance() {
        return instance;
    }
}

<%@ page import="model.PROPOSAL" %>
<%
    String action = request.getParameter("action");
    String proposalIdStr = request.getParameter("proposalId");
    int proposalId = 0;

    if (proposalIdStr != null && !proposalIdStr.isEmpty()) {
        proposalId = Integer.parseInt(proposalIdStr);
    }

    if (action != null && proposalId > 0) {
        if ("approve".equals(action)) {
            PROPOSAL.updateProposalStatus(proposalId, "approved");
        } else if ("reject".equals(action)) {
            PROPOSAL.updateProposalStatus(proposalId, "rejected");
        }
    }

    response.sendRedirect("adminDashboardPage.jsp");
%> 
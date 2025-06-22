<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.PROPOSAL, model.CLUB" %>
<%
    String proposalIdStr = request.getParameter("proposalId");
    int proposalId = 0;
    if (proposalIdStr != null && !proposalIdStr.isEmpty()) {
        proposalId = Integer.parseInt(proposalIdStr);
    }
    PROPOSAL proposal = PROPOSAL.getProposalById(proposalId);
    CLUB club = (proposal != null) ? CLUB.getClubById(proposal.getClubID()) : null;
    String clubName = (club != null) ? club.getClubName() : "N/A";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Proposal</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', Arial, sans-serif; background: #f6f6f6; margin: 0; padding: 40px; }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
        }
        h1 { text-align: center; color: #238B87; margin-bottom: 30px; }
        .detail-row {
            margin-bottom: 20px;
            font-size: 18px;
        }
        .detail-row strong {
            display: inline-block;
            width: 180px;
            color: #333;
        }
        .detail-row span { color: #555; }
        .actions {
            text-align: center;
            margin-top: 40px;
            display: flex;
            gap: 20px;
            justify-content: center;
        }
        .action-btn {
            text-decoration: none;
            color: #fff;
            padding: 12px 30px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            transition: background 0.2s;
        }
        .approve-btn { background: #4caf50; }
        .reject-btn { background: #f44336; }
        .back-btn { background: #777; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Proposal Details</h1>
        <% if (proposal != null) { %>
            <div class="detail-row">
                <strong>Proposal Name:</strong>
                <span><%= proposal.getProposalName() %></span>
            </div>
            <div class="detail-row">
                <strong>Club:</strong>
                <span><%= clubName %></span>
            </div>
            <div class="detail-row">
                <strong>Submission Date:</strong>
                <span><%= proposal.getSubmissionDate() %></span>
            </div>
            <div class="detail-row">
                <strong>Status:</strong>
                <span><%= proposal.getStatus() %></span>
            </div>
            <div class="detail-row">
                <strong>Details:</strong>
                <span><%= proposal.getProposalDetails() %></span>
            </div>

            <div class="actions">
                <a href="handleProposal.jsp?action=approve&proposalId=<%= proposal.getProposalID() %>" class="action-btn approve-btn">Approve</a>
                <a href="handleProposal.jsp?action=reject&proposalId=<%= proposal.getProposalID() %>" class="action-btn reject-btn">Reject</a>
                <a href="adminDashboardPage.jsp" class="action-btn back-btn">Back</a>
            </div>
        <% } else { %>
            <p>Proposal not found.</p>
        <% } %>
    </div>
</body>
</html> 
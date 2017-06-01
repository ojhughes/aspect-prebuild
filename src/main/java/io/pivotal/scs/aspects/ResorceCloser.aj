package io.pivotal.scs.aspects;

import org.apache.http.util.EntityUtils;
import org.eclipse.jgit.transport.http.apache.HttpClientConnection;

import java.io.IOException;

privileged aspect ResourceCloser {

    HttpClientConnection.close() {
        try {
            if (this.response != null) {
                EntityUtils.consume(this.response.getEntity());
                this.response.getEntity().getContent().close();
            }
            this.client.close();
            log.info("Closing JGit client");
        } catch (IOException e) {
            log.error("Error closing JGit HTTP Client: {}", e.getMessage());
        }
    }
}
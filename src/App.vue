<template>
  <div id="app">
    <Header v-bind:title="title" v-bind:subtitle="subtitle" />
    <div class="ts stackable grid container">
      <Contributors
        v-for="repo in repos"
        v-bind:key="repo.name"
        v-bind:repo="repo"
        v-bind:users="users"
      />
    </div>
  </div>
</template>

<script>
import Header from "./components/Header.vue";
import Contributors from "./components/Contributors.vue";

const contributorsURL =
  "https://api.github.com/repos/{{REPO_NAME}}/contributors?anon=1";
const userURL = "https://api.github.com/users/{{USERNAME}}";

const reposToGet = [
  "CCIP-App/CCIP-iOS",
  "CCIP-App/CCIP-Android",
  "CCIP-App/CCIP-Server",
  "CCIP-App/CCIP-Puzzle-Chocolate",
  "CCIP-App/CCIP-Admin-Bueno"
];

export default {
  name: "app",
  components: {
    Header,
    Contributors
  },
  data() {
    return {
      title: "OPass Contributors",
      subtitle: "",

      users: {
        yanyiyi: {
          isLoaded: true,
          login: "yanyiyi",
          name: "Chun Yan Liu",
          avatar_url:
            "https://avatars2.githubusercontent.com/u/4016873?s=460&v=4"
        },
        MukaWang: {
          isLoaded: true,
          login: "MukaWang",
          name: "Muka Wang",
          avatar_url:
            "https://cdn5.telesco.pe/file/e2BZWvrTL7O94aCJXvUH7h7YjigZJOTR8eH7-wqXIYlBLif4Xuzy13IqOiFjq8uelWJMXl2y5YfJwbNe_nTpHsJFVZcl6L7YM1-qVq1tYsqczCSxVw1Gb35jRaKZFNWtlF2GyzO-sRNgy0pocY9Zg5-XByq_IAxOvd0Yc9W-EkeV3ScCdYDAxNcC0kBjBJE4O6sJcrrGo_o2zxNBO7zbnUOR5nSqD19Ywi0Oar8oYNXh_3klBkFrIItvFVBhMnaTV893851sQWrAiIqlJPKoZNcsH7Wi1shDVsf6oEvGetR3RL0d64APjPkllGNYrqv4ppBGtAbFAdpBTATIRhVQLA.jpg"
        }
      },
      repos: [
        {
          name: "Designer",
          users: [{ login: "yanyiyi" }, { login: "MukaWang" }]
        }
      ]
    };
  },
  async mounted() {
    reposToGet.forEach(repo => {
      fetch(contributorsURL.replace("{{REPO_NAME}}", repo)).then(resp => {
        resp.json().then(repoData => {
          this.repos.push({
            name: repo.split("/")[1],
            users: repoData
              .filter(
                contributor =>
                  contributor.login && !contributor.login.includes("bot")
              )
              .map(contributor => {
                return { login: contributor.login };
              })
          });

          repoData.forEach(contributorData => {
            if (contributorData.login in this.users == false) {
              this.$set(this.users, contributorData.login, {
                isLoaded: false,
                name: null,
                login: null,
                avatar_url: null
              });
              fetch(
                userURL.replace("{{USERNAME}}", contributorData.login)
              ).then(userResp => {
                userResp.json().then(userData => {
                  this.users[contributorData.login]["isLoaded"] = true;
                  this.users[contributorData.login]["name"] = userData.name;
                  this.users[contributorData.login]["login"] =
                    contributorData.login;
                  this.users[contributorData.login]["avatar_url"] =
                    contributorData.avatar_url;
                });
              });
            }
          });
        });
      });
    });
  }
};
</script>

<style>
</style>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <!-- Common Head -->
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
<body>
    <jsp:include page="/WEB-INF/views/common/nav.jsp" />

    <div id="app" v-cloak>
        <div class="container">
            <div class="row py-5 mt-4 align-items-center justify-content-center">

                <!-- Registeration Form -->
                <div class="col-md-12 col-lg-8">
                    <form class="needs-validation" @submit="submit">
                        <div class="row">
                            <!-- Name -->
                            <div class="input-group col-lg-12 mb-4">
                                <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-md border-right-0">
                                                <i class="material-icons text-muted">person</i>
                                            </span>
                                </div>
                                <input id="name" type="text" name="name" :value="member.name" class="form-control bg-white border-left-0 border-md" required />
                            </div>

                            <!-- Password -->
                            <div class="input-group col-lg-6 mb-4">
                                <div class="input-group-prepend">
                                        <span class="input-group-text bg-white border-md border-right-0">
                                            <i class="material-icons text-muted">lock</i>
                                        </span>
                                </div>
                                <input id="passwd" type="password" name="passwd" v-model="member.password" placeholder="Password" class="form-control bg-white border-left-0 border-md" required />
                            </div>

                            <!-- Password Confirmation -->
                            <div class="input-group col-lg-6 mb-4">
                                <div class="input-group-prepend">
                                        <span class="input-group-text bg-white border-md border-right-0">
                                            <i class="material-icons text-muted">lock</i>
                                        </span>
                                </div>
                                <input id="passwdConfirmation" type="password" name="passwdConfirmation" placeholder="Confirm Password"
                                       class="form-control bg-white border-left-0 border-md" v-model="member.passwordConfirmation" @input="checkPassword" required />
                            </div>

                            <!-- Email Address -->
                            <div class="input-group col-lg-12 mb-4">
                                <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-md border-right-0">
                                                <i class="material-icons text-muted">email</i>
                                            </span>
                                </div>
                                <input id="email" type="email" name="email" v-model="member.email" placeholder="Email Address"
                                       class="form-control bg-white border-left-0 border-md" @input="checkDuplicateEmail"  required />
                            </div>

                            <!-- Phone Number -->
                            <div class="input-group col-lg-12 mb-4">
                                <div class="input-group-prepend">
                                        <span class="input-group-text bg-white border-md border-right-0">
                                            <i class="material-icons text-muted">phone</i>
                                        </span>
                                </div>
                                <input id="phoneNumber" type="tel" name="phoneNumber" v-model="member.phoneNumber" @input="checkDuplicatePhoneNumber"
                                       class="form-control bg-white border-md border-left-0" placeholder="Phone" required />
                            </div>

                            <!-- ZIP -->
                            <div class="input-group col-lg-12 mb-4">
                                <div class="input-group-prepend">
                                        <span class="input-group-text bg-white border-md border-right-0">
                                            <i class="material-icons text-muted">home</i>
                                        </span>
                                </div>
                                <input id="zip" type="text" name="zip" v-model="member.zip" class="form-control col-3 bg-white border-md border-left-0 border-right-0" required />
                                <a class="text-decoration-none" @click="showPostCode" role="button">
                                        <span class="input-group-text bg-white border-md border-left-0 rounded-right" style="border-radius: 0">
                                            <i class="material-icons text-muted">search</i>
                                        </span>
                                </a>
                            </div>

                            <!-- Address 1 -->
                            <div class="input-group col-lg-6 mb-4">
                                <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-md">
                                                <i class="material-icons text-muted">home</i>
                                            </span>
                                </div>
                                <input id="address1" type="text" name="address1" placeholder="Address 1" v-model="member.address1" class="form-control bg-white border-md border-left-0" required />
                            </div>

                            <!-- Address 2 -->
                            <div class="input-group col-lg-6 mb-4">
                                <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-md">
                                                <i class="material-icons text-muted">home</i>
                                            </span>
                                </div>
                                <input id="address2" type="text" name="address2" placeholder="Address 2" v-model="member.address2" class="form-control bg-white border-md border-left-0" required />
                            </div>

                            <!-- Submit Button -->
                            <div class="form-group col-lg-12 mx-auto mb-0">
                                <button class="btn btn-primary btn-block py-2" type="submit">
                                    <span class="font-weight-bold">Update your account</span>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script type="module">
        const member = JSON.parse('<%= request.getAttribute("member") %>');

        const app = new Vue({
            el: "#app",
            data: {
                member: {
                    ...member,
                    passwordConfirmation: ""
                }
            },
            methods: {
                checkDuplicateEmail: function (e) {
                    fetch("/check?email=" + this.member.email)
                        .then(response => response.text())
                        .then(response => {
                            e.target.setCustomValidity(response === "unique" ? "" : "?????? ???????????? ??????????????????.");
                        });
                },
                checkDuplicatePhoneNumber: function (e) {
                    fetch("/check?phoneNumber=" + this.member.phoneNumber)
                        .then(response => response.text())
                        .then(response => {
                            e.target.setCustomValidity(response === "unique" ? "" : "?????? ???????????? ?????????????????????.");
                        });
                },
                checkPassword: function (e) {
                    this.member.password && e.target.setCustomValidity(this.member.password === this.member.passwordConfirmation ?
                        "" : "??????????????? ???????????? ????????????.");
                },
                showPostCode: function (e) {
                    new daum.Postcode({
                        oncomplete: (data) => {
                            // ???????????? ???????????? ????????? ??????????????? ????????? ????????? ???????????? ??????.
                            // ??? ????????? ?????? ????????? ?????? ????????? ????????????.
                            // ???????????? ????????? ?????? ?????? ????????? ??????('')?????? ????????????, ?????? ???????????? ?????? ??????.
                            let addr = ''; // ?????? ??????
                            let extraAddr = ''; // ???????????? ??????

                            //???????????? ????????? ?????? ????????? ?????? ?????? ?????? ?????? ????????????.
                            if (data.userSelectedType === 'R') { // ???????????? ????????? ????????? ???????????? ??????
                                addr = data.roadAddress;
                            } else { // ???????????? ?????? ????????? ???????????? ??????(J)
                                addr = data.jibunAddress;
                            }

                            // ???????????? ????????? ????????? ????????? ???????????? ??????????????? ????????????.
                            if (data.userSelectedType === 'R') {
                                // ??????????????? ?????? ?????? ????????????. (???????????? ??????)
                                // ???????????? ?????? ????????? ????????? "???/???/???"??? ?????????.
                                if (data.bname !== '' && /[???|???|???]$/g.test(data.bname)) {
                                    extraAddr += data.bname;
                                }
                                // ???????????? ??????, ??????????????? ?????? ????????????.
                                if (data.buildingName !== '' && data.apartment === 'Y') {
                                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                                }
                                // ????????? ??????????????? ?????? ??????, ???????????? ????????? ?????? ???????????? ?????????.
                                if (extraAddr !== '') {
                                    extraAddr = ' (' + extraAddr + ')';
                                }

                            } else {
                                extraAddr = '';
                            }

                            // ??????????????? ?????? ????????? ?????? ????????? ?????????.
                            this.member.zip = data.zonecode;
                            this.member.address1 = addr;
                            this.member.address2 = extraAddr;
                            // ????????? ???????????? ????????? ????????????.
                        }
                    }).open();
                },
                submit: function (e) {
                    e.preventDefault();

                    fetch("/mypage", {
                        method: "put",
                        body: JSON.stringify(this.member)
                    })
                        .then(response => response.text())
                        .then(status => alert(status));
                }
            }
        });
    </script>

    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</body>
</html>

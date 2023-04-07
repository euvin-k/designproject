function deleteInterest(interestId) {
  fetch("/delete-interest", {
    method: "POST",
    body: JSON.stringify({ interestId: interestId }),
  }).then((_res) => {
    window.location.href = "/";
  });
}
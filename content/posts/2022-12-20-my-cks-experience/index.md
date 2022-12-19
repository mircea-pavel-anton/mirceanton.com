---
title: My CKS Experience
description: Secure your cluster and your career with the CKS exam

series: [ "Getting Certified: My Journey Through IT Certifications" ]
series_order: 3

tags:
  - Kubernetes
  - DevOps
  - Security

author: "Mircea-Pavel Anton"
date: "2022-12-20"
---

Hello everyone! In this blog post, I wanted to share my experience taking the Certified Kubernetes Security Specialist (CKS) exam.

I have previously taken the Certified Kubernetes Administrator (CKA) and the Certified Kubernetes Application Developer (CKAD) exams, and I personally found the CKS exam to be more difficult than both of those. However, I believe this was mostly due to my lack of exposure to the topics covered on the CKS exam in my career thus far, as a Junior DevOps engineer.

## 📝 The Exam Difficulty

As I mentioned previously, I would rate the CKS exam as more difficult than the CKA and CKAD. In terms of ranking, I would place the various topics on a tier list as follows:

**Very easy**:

These tasks usually just require one or two basic commands which can be easily found using the `--help` flag even if you forget them

- using `kubesec` to scan and fix manifest files
- using `trivy` to scan images

**Easy**:

These are not particularly difficult, but they do require some knowledge and understanding of how Kubernetes works. I think that, especially if you took the CKA and/or CKAD prior to the CKS, these should be second natura at this point:

- setting up `apparmor` profiles
- configuring `seccomp`
- creating `network policies`
- managing `service accounts` with the appropriate `roles` and `rolebindings`

**Moderate**:

These tasks are not necessarily difficult, but they can be time-consuming and require a fair understanding of how Kubernetes works:

- setting up `admission controllers`
- editing the static pod definition files to secure the cluster

I placed these tasks in this category since validating your work can be quite time consuming since you are editing the static pod manifests on the master node and it can take a bit for the pods to be recreated.

**Difficult**:

In my opinion, this was the most difficult and time-consuming part of the exam. I had not used Falco before and I felt that the amount of practice I was able to get prior to the exam was insufficient to properly "master" it.

- managing `falco` configuration
- configuring `falco` rules

## 📚 Useful Resources

To prepare for the CKS exam, I used the course offered by KodeKloud, as well as their CKS challenges. While I found these resources to be helpful in preparing for the actual exam, I did not feel as ready and confident as I did for the CKA and CKAD. In my opinion, the course quality was not up to par compared to the other two mentioned.

That being said, I would still recommend these resources to others preparing for the CKS exam as they do in fact cover the entire curriculum, just not as well and thorough as I came to expect from them.

## 💻 Technical Aspects

On the technical side, everything went smoothly this time. Unlike my [terrible CKAD experience](http://mirceanton.com/posts/2022-12-13-my-ckad-experience/), I did not have any issues with the PSI system and the check-in process was relatively quick and efficient. The connection was stable throughout the exam with no dropouts, so I had no complaints in this regard.

I would go as far as to say it was almost a flawless experience, but since it is the first and only time things went so well, I am reluctant to make any bold claims. If I were to take another exam with PSI tomorrow, I wouldn't expect it to go this well again, so take that with a grain of salt.

## 💭 Final Thoughts

Overall, while I found the CKS exam to be more difficult than the CKA and CKAD exams, I am glad I took it and I got this. It was a challenging experience, but it helped me to deepen my understanding and strengthen my skills in the area of security, both related to Kubernetes and in general. If you are thinking about taking the CKS exam, I would recommend it, but be prepared to put in some extra study time to ensure you are fully prepared.

I hope this provided some insight to anyone interested in taking the CKS exam!

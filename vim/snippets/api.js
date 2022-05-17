export default function handler(req, res) {
  if (req.method === "GET") {
    res.status(200).json({ greeting: "Hello world" });
  } else {
    res.status(405);
  }
}

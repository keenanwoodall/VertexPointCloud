using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif
using System.Collections.Generic;

[RequireComponent (typeof (MeshFilter))]
[ExecuteInEditMode]
public class VertexPointCloud : MonoBehaviour
{
	public bool draw = true;
	[Space]
	public bool faceCamera = true;
	public float normalOffset = 0f;
	public float globalScale = 0.1f;
	public Vector3 scale = Vector3.one;
	public Vector3 rotationOffset;
	[Space]
	public bool instance = true;
	public Mesh pointMesh;
	public Material pointMaterial;

	private MeshFilter filter;
	private Mesh mesh { get { return filter.sharedMesh; } }
	private List<Matrix4x4> matrices = new List<Matrix4x4> ();
	private Camera mainCamera;
	private Camera currentCamera;
	public Camera CurrentCamera
	{
		get
		{
			if (Camera.current != null)
				currentCamera = Camera.current;
			else if (currentCamera == null)
				currentCamera = mainCamera;

			return currentCamera;
		}
	}


	private void Awake ()
	{
		mainCamera = Camera.main;
		filter = GetComponent<MeshFilter> ();
		if (filter == null)
			filter = gameObject.AddComponent<MeshFilter> ();
	}

	private void Update ()
	{
		if (!draw || pointMesh == null || pointMaterial == null || filter == null)
			return;

		DrawPoints ();
	}

	public void DrawPoints ()
	{
		// Force material instancing.
		if (!pointMaterial.enableInstancing)
		{
			pointMaterial.enableInstancing = true;
			Debug.Log ("The point material doesn't support instancing. Enabling instancing...");
		}

		var vertices = mesh.vertices;
		var normals = mesh.normals;

		// Calculate any values that will be applied to all points outside of the loop.
		var quaternionOffset = Quaternion.Euler (rotationOffset);
		var scaleVector = scale * globalScale;

		// Initialize chunk indexes.
		int startIndex = 0;
		int endIndex = Mathf.Min (1023, mesh.vertexCount);
		int pointCount = 0;

		while (pointCount < mesh.vertexCount)
		{
			// Create points for the current chunk.
			for (int i = startIndex; i < endIndex; i++)
			{
				var position = transform.position + transform.rotation * vertices[i] + transform.rotation * (normals[i].normalized * normalOffset);
				var rotation = Quaternion.identity;
				if (faceCamera)
					rotation = Quaternion.LookRotation (CurrentCamera.transform.position - position);
				else
					rotation = transform.rotation * Quaternion.LookRotation (normals[i]);
				rotation *= quaternionOffset;
				matrices.Add (Matrix4x4.TRS (position, rotation, scaleVector));
				pointCount++;

				if (!instance)
					// Draw the current mesh.
					Graphics.DrawMesh (pointMesh, matrices[i], pointMaterial, 0);
			}

			if (instance)
				// Draw the current chunk.
				Graphics.DrawMeshInstanced (pointMesh, 0, pointMaterial, matrices);

			// Modify start and end index to the range of the next chunk.
			startIndex = endIndex;
			endIndex = Mathf.Min (startIndex + 1023, mesh.vertexCount);

			// Reset the chunk matrices.
			matrices = new List<Matrix4x4> ();
		}
	}
}
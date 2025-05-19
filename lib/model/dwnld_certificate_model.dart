
class CertificateDownloadInfo {
  final bool? status;
  final String? downloadUrl;
  final bool? isEnableDownload;

  CertificateDownloadInfo({
    this.status,
    this.downloadUrl,
    this.isEnableDownload,
  });

  factory CertificateDownloadInfo.fromJson(Map<String, dynamic> json) {
    return CertificateDownloadInfo(
      status: json['status'] as bool?,
      downloadUrl: json['download_url'] as String?,
      isEnableDownload: json['is_enable_download'] as bool?,
    );
  }

  // Optional: toJson method if you ever need to serialize it back
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'download_url': downloadUrl,
      'is_enable_download': isEnableDownload,
    };
  }
}
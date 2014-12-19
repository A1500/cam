package com.inspur.cams.fis.base.data;

import java.io.Serializable;

/**
 * @Path com.inspur.cams.fis.base.data.FisFuneralImportReturn
 * @Description: TODO webservices上报时，中间传输的事件主体，记录传输相关信息
 * @author xuexzh
 * @date 2012-6-20
 */
public class FisFuneralImportReturn implements Serializable {
	// 是否连通
	private boolean ifConnect;
	// 是否上报成功
	private boolean ifFinish;
	// 上报结果描述,一般用于描述错误
	private String uploadResultDesc;

	// 单位编号
	private String unitId;

	// 服务器端的时间（省厅）
	private String serverTimes;
	// 客户端的时间（馆）
	private String clientTimes;
	// 上报开始时间
	private String startTimes;
	// 上报截止时间
	private String endTimes;
	// 最后一次更新时间（暂时以馆时间为准）
	private String lastUpdateTimes;
	// 上报内容描述
	private String contentDesc;
	// 当前系统版本
	private String version;

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public boolean isIfConnect() {
		return ifConnect;
	}

	public void setIfConnect(boolean ifConnect) {
		this.ifConnect = ifConnect;
	}

	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public String getLastUpdateTimes() {
		return lastUpdateTimes;
	}

	public void setLastUpdateTimes(String lastUpdateTimes) {
		this.lastUpdateTimes = lastUpdateTimes;
	}

	public String getEndTimes() {
		return endTimes;
	}

	public void setEndTimes(String endTimes) {
		this.endTimes = endTimes;
	}

	public boolean isIfFinish() {
		return ifFinish;
	}

	public void setIfFinish(boolean ifFinish) {
		this.ifFinish = ifFinish;
	}

	public String getUploadResultDesc() {
		return uploadResultDesc;
	}

	public void setUploadResultDesc(String uploadResultDesc) {
		this.uploadResultDesc = uploadResultDesc;
	}

	public String getServerTimes() {
		return serverTimes;
	}

	public void setServerTimes(String serverTimes) {
		this.serverTimes = serverTimes;
	}

	public String getClientTimes() {
		return clientTimes;
	}

	public void setClientTimes(String clientTimes) {
		this.clientTimes = clientTimes;
	}

	public String getStartTimes() {
		return startTimes;
	}

	public void setStartTimes(String startTimes) {
		this.startTimes = startTimes;
	}

	public String getContentDesc() {
		return contentDesc;
	}

	public void setContentDesc(String contentDesc) {
		this.contentDesc = contentDesc;
	}

}

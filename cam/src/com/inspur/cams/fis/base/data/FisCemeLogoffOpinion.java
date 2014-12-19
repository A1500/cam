package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 同级其它部门意见databean
 * @author 
 * @date 2013-08-15
 */
@Table(tableName = "FIS_CEME_LOGOFF_OPINION", keyFields = "opinionId")
public class FisCemeLogoffOpinion extends StatefulDatabean {

	// 记录编码
	private String opinionId;

	// 业务审批编码
	private String cemeApplyId;


	// 国土资源审核意见
	private String guotuOpinion;

	// 国土资源审核时间
	private String guotuTime;


	// 城乡建设审核意见
	private String townOpinion;

	// 城乡建设审核时间
	private String townTime;


	// 环境保护审核意见
	private String huanbaoOpinion;

	// 环境保护审核时间
	private String huanbaoTime;


	// 林业部门审核意见
	private String linyeOpinion;

	// 林业部门审核时间
	private String linyeTime;
	

	//水利部门审核意见
	private String shuiliOpinion;
	
	//水利部门审核时间
	private String shuiliTime;
	
	//住建部门审核意见
	private String zhujianOpinion;
	
	//住建部门审核时间
	private String zhujianTime;
	
	//本级政府审核意见
	private String zhengfuOpinion;
	
	//本级政府审核时间
	private String zhengfuTime;
	
	//其他部门审核意见
	private String qitaOpinion;
	
	//其他部门审核时间
	private String qitaTime;

	public String getOpinionId() {
		return opinionId;
	}

	public void setOpinionId(String opinionId) {
		this.opinionId = opinionId;
	}

	public String getCemeApplyId() {
		return cemeApplyId;
	}

	public void setCemeApplyId(String cemeApplyId) {
		this.cemeApplyId = cemeApplyId;
	}

	public String getGuotuOpinion() {
		return guotuOpinion;
	}

	public void setGuotuOpinion(String guotuOpinion) {
		this.guotuOpinion = guotuOpinion;
	}

	public String getGuotuTime() {
		return guotuTime;
	}

	public void setGuotuTime(String guotuTime) {
		this.guotuTime = guotuTime;
	}

	public String getTownOpinion() {
		return townOpinion;
	}

	public void setTownOpinion(String townOpinion) {
		this.townOpinion = townOpinion;
	}

	public String getTownTime() {
		return townTime;
	}

	public void setTownTime(String townTime) {
		this.townTime = townTime;
	}

	public String getHuanbaoOpinion() {
		return huanbaoOpinion;
	}

	public void setHuanbaoOpinion(String huanbaoOpinion) {
		this.huanbaoOpinion = huanbaoOpinion;
	}

	public String getHuanbaoTime() {
		return huanbaoTime;
	}

	public void setHuanbaoTime(String huanbaoTime) {
		this.huanbaoTime = huanbaoTime;
	}

	public String getLinyeOpinion() {
		return linyeOpinion;
	}

	public void setLinyeOpinion(String linyeOpinion) {
		this.linyeOpinion = linyeOpinion;
	}

	public String getLinyeTime() {
		return linyeTime;
	}

	public void setLinyeTime(String linyeTime) {
		this.linyeTime = linyeTime;
	}
	public String getShuiliOpinion() {
		return shuiliOpinion;
	}

	public void setShuiliOpinion(String shuiliOpinion) {
		this.shuiliOpinion = shuiliOpinion;
	}

	public String getShuiliTime() {
		return shuiliTime;
	}

	public void setShuiliTime(String shuiliTime) {
		this.shuiliTime = shuiliTime;
	}

	public String getZhujianOpinion() {
		return zhujianOpinion;
	}

	public void setZhujianOpinion(String zhujianOpinion) {
		this.zhujianOpinion = zhujianOpinion;
	}

	public String getZhujianTime() {
		return zhujianTime;
	}

	public void setZhujianTime(String zhujianTime) {
		this.zhujianTime = zhujianTime;
	}
	public String getZhengfuOpinion() {
		return zhengfuOpinion;
	}

	public void setZhengfuOpinion(String zhengfuOpinion) {
		this.zhengfuOpinion = zhengfuOpinion;
	}

	public String getZhengfuTime() {
		return zhengfuTime;
	}

	public void setZhengfuTime(String zhengfuTime) {
		this.zhengfuTime = zhengfuTime;
	}

	public String getQitaOpinion() {
		return qitaOpinion;
	}

	public void setQitaOpinion(String qitaOpinion) {
		this.qitaOpinion = qitaOpinion;
	}

	public String getQitaTime() {
		return qitaTime;
	}

	public void setQitaTime(String qitaTime) {
		this.qitaTime = qitaTime;
	}
	

}
package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.data.SomCert;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;

/**
 * 证书相应插入查询修改
 * @author yanliangliang
 * @date 2011年5月17日20:40:11
 */
public class SomCertSaveCmd extends BaseAjaxCommand {
	private ISomCertDomain somCertDomain=ScaComponentFactory.getService(ISomCertDomain.class, "somCertDomain/somCertDomain");
	public void execute(){
		
	}
	/**
	 * 证书的保存方法
	 */
	public void save(){
		
	}
	/**
	 * 证书的插入方法
	 */
	public  void insert() {
		SomCert somCert=(SomCert)getParameter("somCert");
		String id=somCertDomain.insert(somCert);
		setReturn("id", id);
	}
	/**
	 * 证书的更新方法
	 */
	public  void update() {
		SomCert s=(SomCert)getParameter("somCert");
		somCertDomain.update(s);
	}
	/**
	 * 证书的换发方法
	 */
	public  void change() {
		SomCert s=(SomCert)getParameter("somCert");
		somCertDomain.change(s);
	}
	/***
	 * 证书的收回方法
	 */
	public void receive(){
		SomCert somCert=(SomCert)getParameter("somCert");
		somCertDomain.receive(somCert);
	}
	/**
	 * 获取当前登录信息
	 * 2011年5月18日14:53:35
	 */
	public void getOnLine(){
		String UserName= BspUtil.getEmpOrgan().getOrganName();
		String CorpName= BspUtil.getCorpOrgan().getOrganName();
		setReturn("UserName", UserName);
		setReturn("CorpName", CorpName);
	}
	/**
	 * 综合查询根据证书信息查询社会组织ID
	 * @return
	 */
	public String forQuery(){
		ParameterSet pset = getParameterSet();
		String idString=somCertDomain.queryForQuery(pset);
		setReturn("idString", idString);
		return "";	
	}
}

package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.data.SomCert;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;

/**
 * @author zhaojin
 * 创建时间:2011-10-17
 * SomCertCmd
 * 说明:
 */
public class SomCertCmd extends BaseAjaxCommand {

	private ISomCertDomain somCertDomain = ScaComponentFactory.getService(ISomCertDomain.class, "somCertDomain/somCertDomain");

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

package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.dao.ISomBorgDao;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.domain.ISomBorgChangeDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;

/**
 * 证书查询
 * @author yanliangliang
 * @date 2011年5月12日17:54:24
 */
public class SomCertQueryCmd extends BaseQueryCommand{

	private ISomCertDomain somCertDomain=ScaComponentFactory.getService(ISomCertDomain.class, "somCertDomain/somCertDomain");
	private ISomOrganDomain somOrganDomain=ScaComponentFactory.getService(ISomOrganDomain.class, "somOrganDomain/somOrganDomain");
	private ISomDutyDomain somDutyDomain=ScaComponentFactory.getService(ISomDutyDomain.class, "somDutyDomain/somDutyDomain");
	private ISomBorgChangeDomain somBorgChangeDomain = ScaComponentFactory
	.getService(ISomBorgChangeDomain.class,
			"somBorgChangeDomain/somBorgChangeDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somCertDomain.query(pset);
	}
	public DataSet createCert(){
		String id=(String)getParameter("SORG_ID");
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID@=", id);
		SomOrgan somOrgan= (SomOrgan)somOrganDomain.query(pset).getRecord(0).toBean(SomOrgan.class);

		String endDate=(String)getParameter("endDate");
		String beginDate=(String)getParameter("beginDate");
		String PrintDate=(String)getParameter("PrintDate");
		String taskCode=(String)getParameter("taskCode");
		String legalPeople=(String)getParameter("legalPeople");
		String organCode=(String)getParameter("organCode");
		String[] s1=endDate.split("-");
		String[] s2=beginDate.split("-");
		String[] s3=PrintDate.split("-");
		Record certRecord=new Record();

		//certRecord.set("sorgCode",somOrgan.getSorgCode());
		certRecord.set("sorgKind",somOrgan.getSorgKind());
		certRecord.set("sorgName",somOrgan.getCnName());
		certRecord.set("business",somOrgan.getBusiness());
		certRecord.set("residence",somOrgan.getResidence());
		if(somOrgan.getIfBranch().equals("0")){
			certRecord.set("actArea",somOrgan.getActArea());
		}else{
			//分支的需要取主体的活动地域和自己的主要负责人
			ParameterSet pset2=new ParameterSet();
			pset2.setParameter("SORG_ID@=", somOrgan.getMainSorgId());
			SomOrgan somOrganMain= (SomOrgan)somOrganDomain.query(pset2).getRecord(0).toBean(SomOrgan.class);
			certRecord.set("actArea",somOrganMain.getActArea());
		}
		if(legalPeople == null ||legalPeople == ""){
			certRecord.set("legalPeople",somOrgan.getLegalPeople() );
		}else{
			certRecord.set("legalPeople",legalPeople);
		}
		if(organCode == null ||organCode == ""){
			certRecord.set("organCode",somOrgan.getOrganCode() );
		}else{
			certRecord.set("organCode",organCode);
		}
		certRecord.set("regMon",somOrgan.getRegMon() );
		String borgCode = somOrgan.getBorgName();
		ParameterSet pset2=new ParameterSet();
		pset2.setParameter("BORG_CODE@=", borgCode);
		String nowBorgCode = somBorgChangeDomain.nowBorgName(pset2);
		if(!nowBorgCode.equals("")){
			certRecord.set("borgName",getBorgName(nowBorgCode) );
		}else{
			certRecord.set("borgName",getBorgName(borgCode) );
		}

		certRecord.set("signOrgan",BspUtil.getCorpOrgan().getOrganName());
		certRecord.set("QYear", s2[0]);

		certRecord.set("QMonth",s2[1] );
		certRecord.set("QDay", s2[2]);
		certRecord.set("ZYear", s1[0]);
		certRecord.set("ZMonth", s1[1]);
		certRecord.set("ZDay", s1[2]);

		certRecord.set("FYear", s3[0]);
		certRecord.set("FMonth", s3[1]);
		certRecord.set("FDay", s3[2]);
		DataSet cert=new DataSet();
		cert.addRecord(certRecord);
//		cert.add(certRecord);
		return cert;
	}
	public String getBorgName(String code){
		ISomBorgDao dao = (ISomBorgDao) DaoFactory.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomBorgDao");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("BORG_CODE@=", code);
		DataSet ds = dao.query(pset);
		if(ds.getCount() == 1){
			return (String) ds.getRecord(0).get("borgName");
		}
		return "";
	}

}

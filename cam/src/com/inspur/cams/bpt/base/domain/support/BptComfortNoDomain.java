package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;



import com.ctc.wstx.util.DataUtil;
import com.inspur.cams.bpt.base.dao.IBptComfortNoDao;
import com.inspur.cams.bpt.base.dao.IBptPeopleWarDao;
import com.inspur.cams.bpt.base.data.BptComfortNo;
import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.bpt.base.domain.IBptComfortNoDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.comm.util.DateUtil;

public class BptComfortNoDomain implements IBptComfortNoDomain{
	@Reference
	private IBptComfortNoDao bptComfortNoDao;
	private DateUtil dateUtil=new DateUtil();
public String getNO( String flag,String domicileCode){
		
		ParameterSet pst= new ParameterSet();
		pst.setParameter("domicile_code", domicileCode.substring(0, 6));
		DataSet ds = bptComfortNoDao.query(pst);
		String no=null;
		if(ds.getCount()==1){
			BptComfortNo bean =(BptComfortNo)ds.getRecord(0).toBean(BptComfortNo.class);
			if("CZ".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getWarNo());
				bean.setWarNo(no);
			}else if("CS".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getTestNo());
				bean.setTestNo(no);
			}else if("DB".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getDemobilizedIllnessNo());
				bean.setDemobilizedIllnessNo(no);
			}else if("ZX".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getDemobilizedNo());
				bean.setDemobilizedNo(no);
			}else if("LS".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getRevolutionNo());
				bean.setRevolutionNo(no);
			}else if("YG".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getDutyNo());
				bean.setDutyNo(no);
			}else if("BG".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getDeceaseNo());
				bean.setDeceaseNo(no);
			}
			bptComfortNoDao.update(bean);
		}else if(ds.getCount()<1){
			BptComfortNo bean =new BptComfortNo();
			bean.setDomicileCode(domicileCode.substring(0, 6));
			if("CZ".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getWarNo());
				bean.setWarNo(no);
			}else if("CS".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getTestNo());
				bean.setTestNo(no);
			}else if("DB".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getDemobilizedIllnessNo());
				bean.setDemobilizedIllnessNo(no);
			}else if("ZX".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getDemobilizedNo());
				bean.setDemobilizedNo(no);
			}else if("LS".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getRevolutionNo());
				bean.setRevolutionNo(no);
			}else if("YG".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getDutyNo());
				bean.setDutyNo(no);
			}else if("BG".equals(flag)){
				no =returnNo(flag,domicileCode,bean.getDeceaseNo());
				bean.setDeceaseNo(no);
			}
			bptComfortNoDao.insert(bean);
		}
		return no;
	}
	
	public String returnNo(String flag ,String domicileCode,String no){
		StringBuffer NO = new StringBuffer();
		String date = (String)dateUtil.getYear();
		String domicile = domicileCode.substring(2, 6);
		NO.append(flag);
		NO.append(domicile);
		if(no!=null){
			String NoDate= no.substring(6, 10);
			String NoNum = no.substring(6);
			Integer num = Integer.parseInt(NoNum)+1;
			String number =num.toString().substring(4);
			
			if(NoDate.equals(date)){
				NO.append(NoDate);
				NO.append(number);
			}else{
				NO.append(date);
				NO.append("00001");
			}
			return NO.toString();
		}else{
			NO.append(date);
			NO.append("00001");
			return NO.toString();
		}
		
	}
}

package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.drel.sam.dao.ISamIdCardDao;
import com.inspur.cams.drel.sam.data.SamIdCard;
import com.inspur.cams.drel.sam.domain.ISamIdCardDomain;

/**
 * @title:身份代码domain
 * @description:
 * @author:zhangjian
 * @since:2011-06-18
 * @version:1.0
 */
public class SamIdCardDomain implements ISamIdCardDomain {
	@Reference
	private ISamIdCardDao samIdCardDao;
	public DataSet query(ParameterSet pset) {
		return samIdCardDao.query(pset);
	}

	public String getIdCard(String sex,String birthday) {
		String domicileCode=BspUtil.getCorpOrgan().getOrganCode();
		String id=domicileCode.substring(0, 6)+birthday;
		ParameterSet pst = new ParameterSet();
		pst.setParameter("ID", id);
		DataSet ds = samIdCardDao.query(pst);
		String idCard = null;
		if (ds.getCount() == 1) {
			SamIdCard samIdCard = (SamIdCard) ds.getRecord(0).toBean(SamIdCard.class);
			if ("1".equals(sex)) {
				idCard = returnIdCard(id,sex,birthday,samIdCard.getIdCardMan());
				samIdCard.setIdCardMan(idCard);
			} else if ("2".equals(sex)) {
				idCard = returnIdCard(id,sex,birthday,samIdCard.getIdCardWoman());
				samIdCard.setIdCardWoman(idCard);
			} 
			samIdCardDao.update(samIdCard);
		} else if (ds.getCount() < 1) {
			SamIdCard samIdCard = new SamIdCard();
			samIdCard.setId(id);
			if ("1".equals(sex)) {
				idCard = returnIdCard(id,sex,birthday,samIdCard.getIdCardMan());
				samIdCard.setIdCardMan(idCard);
			} else if ("2".equals(sex)) {
				idCard = returnIdCard(id,sex,birthday,samIdCard.getIdCardWoman());
				samIdCard.setIdCardWoman(idCard);
			} 
			samIdCardDao.insert(samIdCard);
		}
		return idCard;
	}

	public String returnIdCard(String id,String sex,String birthday,String lastIdCard) {
		StringBuffer idCard = new StringBuffer();
		idCard.append(id);
		if (lastIdCard != null) {
			String lastNo = lastIdCard.substring(14,16);
			Integer no = Integer.parseInt(lastNo) + 1;
			String num=no.toString().substring(0);
			if(num.length()<2){
				num="0"+num;
			}
			idCard.append(num);
			idCard.append(sex);
			idCard.append("N");
			return idCard.toString();
		} else {
			idCard.append("01");
			idCard.append(sex);
			idCard.append("N");
			return idCard.toString();
		}
	}
}

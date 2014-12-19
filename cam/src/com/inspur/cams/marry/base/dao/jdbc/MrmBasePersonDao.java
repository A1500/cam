package com.inspur.cams.marry.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.PhotoUtil;
import com.inspur.cams.marry.base.dao.IMrmBasePersonDao;
import com.inspur.cams.marry.base.data.MrmBasePerson;

/**
 * @title:MrmBasePersonDao
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
 public class MrmBasePersonDao extends EntityDao<MrmBasePerson> implements IMrmBasePersonDao{

 	public MrmBasePersonDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return MrmBasePerson.class;
	}
  	
  	/**
	  * 根据loginid查看有无重复登录的用户名
	  * @param idCard
	  * @return
	  */
	public boolean  getByLoginId(String loginId){
		StringBuffer sql=new StringBuffer();
		@SuppressWarnings("unused")
		List typeList = new ArrayList();
		@SuppressWarnings("unused")
		List<Object> argsList = new ArrayList();
		sql.append("SELECT p.*  FROM PUB_USERS p  WHERE p.USER_ID= UPPER(?)");
		List list=this.executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{loginId});
		int num=list.size();
		if(num==0||list==null){
			 return false;//没有对应的用户
		}else{  
			 return true;//有对应的用户了
		}
	}
  	
  	/**
	  * 根据organCode获取organId
	  * @param idCard
	  * @return
	  */
	public String getDeptId(String loginid){
		StringBuffer sql=new StringBuffer();
		@SuppressWarnings("unused")
		List typeList = new ArrayList();
		@SuppressWarnings("unused")
		List<Object> argsList = new ArrayList();
		sql.append("SELECT p.DEPT_ID, p.DEPT_NAME FROM MRM_BASE_PERSON p  WHERE p.LOGINID = LOWER(?)");
		List list=this.executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{loginid});
		int num=list.size();
		if(num==0||list==null){
			return "0";
		}else{  
			StringBuffer sb=new StringBuffer();
			String deptId=(String)((Map)list.get(0)).get("DEPT_ID");
			String deptName=(String)((Map)list.get(0)).get("DEPT_NAME");
			return sb.append(deptId).append(",").append(deptName).toString();
		}
	}
	/**
	 * 更新照片
	 */
	public String updatePhoto(String photo, String photoTemp) {
		if(photo!=null && !("".equals(photo.trim()))){
			if(photoTemp!=null && !("".equals(photoTemp.trim()))){
				//删除原照片
				StringBuffer querySql = new StringBuffer();
				String tableName = "COM_PHOTO_"+photo.substring(0,6);
				querySql.append("delete from ").append(tableName).append(" where PHOTO_ID=?");
				this.executeUpdate(querySql.toString(), new int[]{Types.VARCHAR}, new Object[]{photo});
				//保存新照片
				String newPhotoId = PhotoUtil.savePhoto(photoTemp);
				return newPhotoId;
			}else{
				return photo;
			}
		}else{
			if(photoTemp!=null && !("".equals(photoTemp.trim()))){
				//保存新照片
				String newPhotoId = PhotoUtil.savePhoto(photoTemp);
				return newPhotoId;
			}
			return null;
		}
	}
	/**
	 * 更新签名
	 */
	public String updateQm(String qmName, String qmTemp) {
		if(qmName!=null && !("".equals(qmName.trim()))){
			if(qmTemp!=null && !("".equals(qmTemp.trim()))){
				//删除原签名qmName
				StringBuffer querySql = new StringBuffer();
				String tableName = "COM_PHOTO_"+qmName.substring(0,6);
				querySql.append("delete from ").append(tableName).append(" where PHOTO_ID=?");
				this.executeUpdate(querySql.toString(), new int[]{Types.VARCHAR}, new Object[]{qmName});
				//新签名
				String newQmNameId = PhotoUtil.savePhoto(qmTemp);
				return newQmNameId;
			}else{
				return qmName;
			}
		}else{
			if(qmTemp!=null && !("".equals(qmTemp.trim()))){
				//保存新照片
				String newQmNameId = PhotoUtil.savePhoto(qmTemp);
				return newQmNameId;
			}
			return null;
		}
	}
	/**
	 * 报名人员信息
	 */
	public DataSet examApplyDataSet(ParameterSet pSet){
		String deptId = (String) pSet.getParameter("deptId");
		String year = (String) pSet.getParameter("year");
		String bzyCode = (String) pSet.getParameter("bzyCode");
		
		StringBuffer eaSqlBuffer = new StringBuffer(); 
		eaSqlBuffer.append(" select m.person_id,m.dept_id,m.name,m.sex,m.card_no, m.file_name,m.file_path, q.ksqs, q.kssj_time, q.ksap_id,q.give_out_time,'' as give\n ");
		eaSqlBuffer.append(" from mrm_base_person m,mrm_qualification_exam q, mrm_exam_schedule s where m.person_id=q.person_id\n "); 
		eaSqlBuffer.append(" and q.ksap_id=s.ksap_id " );
		List typeList = new ArrayList();
		List<Object> argesList = new ArrayList();
		if (deptId != null && !"".equals(deptId)) {
			eaSqlBuffer.append("and dept_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(deptId);
		}
		if (bzyCode != null && !"".equals(bzyCode)) {
			if ("01".equals(bzyCode)) {
				eaSqlBuffer.append(" and s.ks_sign='0'");
			}else if ("02".equals(bzyCode)) {
				eaSqlBuffer.append(" and s.ks_sign='1'");
			}
		}
		
		if (year != null && !"".equals(year)) {
			eaSqlBuffer.append(" and s.nd_year=?");
			typeList.add(Types.VARCHAR);
			argesList.add(year);
		}
		eaSqlBuffer.append(" union all select m.person_id,m.dept_id,m.name,m.sex,m.card_no, m.file_name,m.file_path, ");
		eaSqlBuffer.append(" '' AS ksqs, '' AS kssj_time, '' AS ksap_id,'' as give_out_time,'' as give\n");		
		eaSqlBuffer.append("from mrm_base_person m where 1 = 1");		
		if (deptId != null && !"".equals(deptId)) {
			eaSqlBuffer.append(" and dept_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(deptId);
		}
		if (bzyCode != null && !"".equals(bzyCode)) {
			if ("02".equals(bzyCode)) {
				eaSqlBuffer.append(" and m.bzy_code='02'");
			}
		}
		eaSqlBuffer.append(" and m.person_id not in (");
		eaSqlBuffer.append(" select q.person_id from mrm_qualification_exam q,mrm_exam_schedule s where q.ksap_id=s.ksap_id");
		if (bzyCode != null && !"".equals(bzyCode)) {
			if ("01".equals(bzyCode)) {
				eaSqlBuffer.append(" and s.ks_sign='0'");
			}else if ("02".equals(bzyCode)) {
				eaSqlBuffer.append(" and s.ks_sign='1'");
			}
		}
			
		if (year != null && !"".equals(year)) {
			eaSqlBuffer.append(" and s.nd_year=?");
			typeList.add(Types.VARCHAR);
			argesList.add(year);
		}	
		eaSqlBuffer.append(") and m.name not like '%婚姻%'");
		
		DataSet dataSet = null;
		if (typeList.size() != 0 && argesList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argesList.toArray(new Object[typeList.size()]);
			
			dataSet =  this.executeDataset(eaSqlBuffer.toString(), types, args, true);
		}else {
			dataSet =  this.executeDataset(eaSqlBuffer.toString(), true);
		}
		return dataSet;
	}
	
	/**
	 * 升为颁证员
	 */
	public void updateBzy(MrmBasePerson mPerson){
		String personId = mPerson.getPersonId();
		String bzyCode = mPerson.getBzyCode();
		StringBuffer bzyBuffer = new StringBuffer();
		bzyBuffer.append("update MRM_BASE_PERSON ");
		
		List typeList = new ArrayList();
		List<Object> argesList = new ArrayList();
		if (bzyCode != null && !"".equals(bzyCode)) {
			bzyBuffer.append("set bzy_code = ? ");
			typeList.add(Types.VARCHAR);
			argesList.add(bzyCode);
		}
		
		if (personId != null && !"".equals(personId)) {
			bzyBuffer.append("where person_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(personId);
		}
		DataSet dataSet = null;
		if (typeList.size() != 0 && argesList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argesList.toArray(new Object[typeList.size()]);
			
			 this.executeUpdate(bzyBuffer.toString(), types, args);
		}
	}
	//办证员证号
	public void updateBzyzh(MrmBasePerson mPerson){
		String personId = mPerson.getPersonId();
		String bzyzgzh = mPerson.getBzyzgzh();
		StringBuffer bzyBuffer = new StringBuffer();
		bzyBuffer.append("update MRM_BASE_PERSON ");
		
		List typeList = new ArrayList();
		List<Object> argesList = new ArrayList();
		
		if (bzyzgzh != null && !"".equals(bzyzgzh)) {
			bzyBuffer.append(" set bzyzgzh = ? ");
			typeList.add(Types.VARCHAR);
			argesList.add(bzyzgzh);
		}else {
			bzyBuffer.append(" set bzyzgzh = '' ");
		}
		
		if (personId != null && !"".equals(personId)) {
			bzyBuffer.append("where person_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(personId);
		}
		DataSet dataSet = null;
		if (typeList.size() != 0 && argesList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argesList.toArray(new Object[typeList.size()]);
			
			 this.executeUpdate(bzyBuffer.toString(), types, args);
		}
	}
	//登记员证号
	public void updateCertificate(MrmBasePerson mPerson){
		String personId = mPerson.getPersonId();
		String certificateId = mPerson.getCertificateId();
		StringBuffer bzyBuffer = new StringBuffer();
		bzyBuffer.append("update MRM_BASE_PERSON ");
		
		List typeList = new ArrayList();
		List<Object> argesList = new ArrayList();
		
		if (certificateId != null && !"".equals(certificateId)) {
			bzyBuffer.append("set certificate_id = ? ");
			typeList.add(Types.VARCHAR);
			argesList.add(certificateId);
		}else {
			bzyBuffer.append("set certificate_id = '' ");
		}
		
		if (personId != null && !"".equals(personId)) {
			bzyBuffer.append("where person_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(personId);
		}
		DataSet dataSet = null;
		if (typeList.size() != 0 && argesList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argesList.toArray(new Object[typeList.size()]);
			
			 this.executeUpdate(bzyBuffer.toString(), types, args);
		}
	}
	public BigDecimal getDjyNum(String deptId) {//登记员人数
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) AS DJYNUM from MRM_BASE_PERSON p where p.dept_id= ? and  p.workstate='01' and p.certificate_id is not null and (to_char(sysdate, 'yyyy') - substr(p.party_Time, 1, to_number(instr(p.party_Time, '-')-1)))<3");
		List list=this.executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{deptId});
		BigDecimal djyNum=new BigDecimal(0);
		if(list.size()>0){
			djyNum=(BigDecimal)((Map)list.get(0)).get("DJYNUM");
		}
		return djyNum;
	}
	public BigDecimal getBzyNum(String deptId) {//获得颁证员人数
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) AS DJYNUM from MRM_BASE_PERSON p where p.dept_id= ? and p.bzy_code='02' and  p.workstate='01'  and p.bzyzgzh is not null and p.certificate_id is not null and (to_char(sysdate, 'yyyy') - substr(p.party_Time, 1, to_number(instr(p.party_Time, '-')-1)))<3");
		List list=this.executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{deptId});
		BigDecimal bzyNum=new BigDecimal(0);
		if(list.size()>0){
			bzyNum=(BigDecimal)((Map)list.get(0)).get("DJYNUM");
		}
		return bzyNum;
	}
	
	public BigDecimal getXzbzNum(String deptId) {//行政编制人数
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) AS DJYNUM from mrm_base_person p where  p.dept_id= ? and  p.kind='01' and  p.workstate='01' and p.certificate_id is not null and (to_char(sysdate, 'yyyy') - substr(p.party_Time, 1, to_number(instr(p.party_Time, '-')-1)))<3");
		List list=this.executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{deptId});
		BigDecimal xzbzNum=new BigDecimal(0);
		if(list.size()>0){
			xzbzNum=(BigDecimal)((Map)list.get(0)).get("DJYNUM");
		}
		return xzbzNum;
	}
	
	public BigDecimal getCgglNum(String deptId) {//参公管理事业编人数 01:公务员,02:全额事业编,03:参公管理事业编,04:其他
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*)AS DJYNUM from mrm_base_person p where  p.dept_id= ? and  p.kind='03' and  p.workstate='01' and p.certificate_id is not null and (to_char(sysdate, 'yyyy') - substr(p.party_Time, 1, to_number(instr(p.party_Time, '-')-1)))<3");
		List list=this.executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{deptId});
		BigDecimal cgglNum=new BigDecimal(0);
		if(list.size()>0){
			cgglNum=(BigDecimal)((Map)list.get(0)).get("DJYNUM");
		}
		return cgglNum;
	}
	
	public BigDecimal getQebkNum(String deptId) {//全额拨款事业编人数
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) AS DJYNUM from mrm_base_person p where  p.dept_id= ? and  p.kind='02' and  p.workstate='01' and p.certificate_id is not null and (to_char(sysdate, 'yyyy') - substr(p.party_Time, 1, to_number(instr(p.party_Time, '-')-1)))<3");
		List list=this.executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{deptId});
		BigDecimal qebkNum=new BigDecimal(0);
		if(list.size()>0){
			qebkNum=(BigDecimal)((Map)list.get(0)).get("DJYNUM");
		}
		return qebkNum;
	}
}

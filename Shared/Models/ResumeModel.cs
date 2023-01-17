namespace Models
{
    public class ResumeModel
    {
        public string About { get; set; } = default;

        public IEnumerable<ExperienceModel> Experiences { get; set; } 
        public IEnumerable<EducationModel> Educations { get; set; }
        public IEnumerable<SkillModel> Skills { get; set; }
    }   
    
}